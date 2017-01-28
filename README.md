# Insightful apps on OpenShift

This workshop will teach you how to develop and deploy insightful apps with Apache Spark and OpenShift.

## Prerequisites

For the hands-on portion, you'll need Docker or a compatible container runtime installed (to run the notebook images) and OpenShift Origin (to build and deploy the application).  These are easy to install, but if you absolutely can't install Origin, don't worry -- you can still use the notebooks to learn more about Apache Spark, data engineering, machine learning, and simulation.  You can also run the application we'll build under Docker or just as a regular process on your laptop.  (If you absolutely can't install Docker, we have a way for you to follow along, too; see below.)

## Installing images and cloning repositories

You'll want to pull the `willb/workshop:notebook` image:

`docker pull willb/workshop`

You'll also want to clone the [git repository](https://github.com/radanalyticsio/var-sandbox) for the application skeleton we'll be fleshing out in the workshop:

`git clone https://github.com/radanalyticsio/var-sandbox`.

To run the notebook, use

`docker run --name workshop-notebook -d -p 8888:8888 willb/workshop:notebook`

This will print out a container hash.  You'll then use either the name we specified (`workshop-notebook`) or the hash (if, for some reason, you wanted to use a different name) to find the URL to log in to your notebook, by doing this:

`docker exec workshop-notebook jupyter notebook list`

Open the URL that command prints out and you're ready to go.

When you're done, download any modified notebook files that you want to save (or copy them out directly with `docker cp workshop-notebook:/notebooks/$FILE .`) and then delete the container with `docker rm workshop-notebook`.

## If you can't install Docker

If you can't install Docker or run the images for whatever reason, don't worry!  This repository contains [IPython notebook](/notebooks) files for the hands-on portion of the workshop and GitHub will (mostly) render them, so you can follow along with those.  (We recommend installing them locally so you can experiment with a live notebook yourself when you get a chance, of course.)