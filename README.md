# Intelligent Applications on OpenShift with radanalytics.io
 
This workshop will teach you how to use radanalytics.io to develop and deploy intelligent applications with Apache Spark and OpenShift.

## Prerequisites

Ideally, you'll want access to an OpenShift cluster (either Origin or OpenShift Container Platform) -- a local cluster that you've created with [`oc cluster up`](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md) is fine.  If you have Docker or a compatible container runtime installed, you can run the notebook images.  It is also possible to run the notebooks outside of a container runtime, but we recommend running them in containers to simplify deployment.

## Running the workshop in OpenShift

OpenShift is the easiest way to run the workshop, whether you're running against a hosted OpenShift environment or whether you've created a local development environment with `oc cluster up`.  You'll need [this `resources.yaml` file](/openshift/resources.yaml) to set things up.  First, create a project:

`oc new-project workshop`

Then use the template to create the necessary resources:

`oc create -f https://raw.githubusercontent.com/radanalyticsio/workshop/develop/openshift/resources.yaml`

Then you'll be able to add the `var-notebook` application to your project and run it.  There will be a route created for you after the notebook server starts up.  Visit that route and log in with password `developer`.

## Running the notebooks locally with Docker

If you can't run OpenShift for some reason, you can run the notebook image in Docker.  You'll want to pull the `radanalyticsio/workshop-notebook` image:

`docker pull radanalyticsio/workshop-notebook:latest`

You'll also want to clone the [git repository](https://github.com/radanalyticsio/var-sandbox) for the application skeleton we'll be fleshing out in the workshop:

`git clone https://github.com/radanalyticsio/var-sandbox`.

To run the notebook, use

`docker run --name workshop-notebook -d -p 8888:8888 radanalyticsio/workshop-notebook:latest`

This will print out a container hash.  You'll then use either the name we specified (`workshop-notebook`) or the hash (if, for some reason, you wanted to use a different name) to find the URL to log in to your notebook, by doing this:

`docker exec workshop-notebook jupyter notebook list`

Open the URL that command prints out and you're ready to go.

When you're done, download any modified notebook files that you want to save (or copy them out directly with `docker cp workshop-notebook:/notebooks/$FILE .`) and then delete the container with `docker rm workshop-notebook`.

## If you can't run containers

If you can't install OpenShift, can't install Docker, or can't run the images for whatever reason, don't worry!  This repository contains [IPython notebook](/notebooks) files for the hands-on portion of the workshop and GitHub will (mostly) render them, so you can follow along with those.  (We recommend installing them locally so you can experiment with a live notebook yourself when you get a chance, of course.)
