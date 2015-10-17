#!/bin/bash

echo "Initializing MongoDB with test data..."
#mongodump --out /vagrant/data
mongorestore /vagrant/data