# Insightful apps on OpenShift

This workshop will teach you how to deploy insightful apps on OpenShift.

For the hands-on portion, you'll want to pull the `willb/workshop:notebook` image:

`docker pull willb/workshop`

You'll also want to clone the [git repository](https://github.com/elmiko/var-sandbox) for the application skeleton we'll be fleshing out in the workshop:

`git clone https://github.com/elmiko/var-sandbox`.

To run the notebook, use

`docker run --name workshop-notebook -d -p 8888:8888 willb/workshop:notebook`

This will print out a container hash.  You'll then use either the name we specified (`workshop-notebook`) or the hash (if, for some reason, you wanted to use a different name) to find the URL to log in to your notebook, by doing this:

`docker exec workshop-notebook jupyter notebook list`

Open the URL that command prints out and you're ready to go.

When you're done, download any modified notebook files that you want to save (or copy them out directly with `docker cp /notebooks/$FILE .`) and then delete the container with `docker rm workshop-notebook`.