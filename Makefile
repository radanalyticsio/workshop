LOCAL_IMAGE=$(USER)/workshop-notebook
TEST_CONTAINER=test-workshop-notebook

.PHONY: build clean run test

build:
	docker build -t $(LOCAL_IMAGE) .

clean:
	-docker rmi -f $(LOCAL_IMAGE)
	-docker rm -f $(TEST_CONTAINER)

run:
	docker run -p 8888:8888 -e JUPYTER_NOTEBOOK_PASSWORD=developer $(LOCAL_IMAGE)

test:
	-docker rm -f $(TEST_CONTAINER)
	# remove the container in 10 minutes (timeout)
	-(sleep $$[10*60] && docker rm -f $(TEST_CONTAINER))&
	pid=$$!

	docker run -d -e TRAVIS_PULL_REQUEST="$(TRAVIS_PULL_REQUEST)" --name $(TEST_CONTAINER) $(LOCAL_IMAGE)
	for f in .travis/setup.sh .travis/notebooks-perf-test.sh .travis/publish.sh ; do \
		docker cp $$f $(TEST_CONTAINER):/notebooks/ ; \
	done
	docker exec --user 0 $(TEST_CONTAINER) /notebooks/setup.sh
	docker exec $(TEST_CONTAINER) /notebooks/notebooks-perf-test.sh
	docker rm -f $(TEST_CONTAINER)
	-kill $(pid)
