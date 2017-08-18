#!/bin/bash
set -x

# use the png backend for matplotlib
export MPLBACKEND="Agg"

export PYTHONPATH=$SPARK_HOME/python:$(echo $SPARK_HOME/python/lib/py4j-*-src.zip)

NOTEBOOKS="ml-basics pyspark var" #var-demo workshop
for notebook in $NOTEBOOKS ; do
  [ ! -f "./$notebook.ipynb" ] && echo "Skipping $notebook.ipynb because it doesn't exist" && continue

  echo -e "\n\nRunning the perf test for $notebook\n\n"

  # convert the notebook to executable script
  jupyter nbconvert --to script $notebook.ipynb --Application.log_level=DEBUG --output=test
  NBC_CODE=$?
  # accumulative error xored with other return codes
  ACC_CODE="$[$NBC_CODE ^ ${ACC_CODE:-0}]"
  [ $NBC_CODE -ne 0 ] && echo "perf test for $notebook notebook wasn't possible to run" >> all.perf && continue

  # comment out the lines starting with 'get_ipython' (originally %matplotlib or %config)
  sed -i'' 's/^\(get_ipython.*\)/#\1/' test.py

  # run the notebook and measure the execution time
  /usr/bin/time -f'%E' -o $notebook.perf -- ipython test.py
  ACC_CODE="$[$? ^ ${ACC_CODE}]"
  echo perf test for $notebook notebook took `cat $notebook.perf` >> all.perf
done

# print results to stdout
echo -e "\n\nAll results:\n"
cat all.perf

if [ $ACC_CODE -ne 0 ]; then
  # failure
  echo -e "\n\nSome of the tests above failed\n\n"
  exit $ACC_CODE
else
  # success
  echo -e "\n\nTests were successfuly run\n\n"
  ./publish.sh
fi

exit 0
