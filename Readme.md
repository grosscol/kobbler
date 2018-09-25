# Knowledge Object Build Utility

## Description
Knowledge Grid Knowledge Objects for development with the Landis-Lewis Lab.

## Prerequisites
* Knowledge Grid Activator is running locally on port 8080.
* Ruby 2.4.1 
* Gem dependencies installed
    ```
    bundle install
    ```

## Setup
1. Build docker image
    ```
    docker build -f activator.dockerfile -t kgrid-activator-1.0.1
    ```
1. Create/Run docker container
    ```
    docker create --name kga -p 8080:8080 kgrid-activator-1.0.1
    ```
1. Start and test docker container
    ```
    docker start kga
    curl localhost:8080/hello/world
    ```

## Use
### Build KGrid Knowledge Objects from Sources
Build all the knowledge objects
```
rake kobble
```

### Loading Knowledge Objects into Activator
Load the count-spek knowledge object into the activator
```
rake activate['count-spek']
```
or
```
curl -X PUT localhost:8080/count/spek --form ko=@build/count-spek.zip
```

### Test the Knowledge Object
Test the hello-js knowledge object is loaded.
```
rake test['count-spek']
```
or
```
curl localhost:8080/count/spek 
```

## Authoring New Knowledg Objects
1. Make directory under src/
1. Write metadata.yml
1. Write payload
1. Run rake task to build all knowledge objects
    ```
    rake kobble
    ```

## Loading Knowledge Objects
The options for putting a knowledge object into an activator are:
* PUT request to running Activator
* Add to shelf directory of Activator before starting it.
* Add to Knowledge Grid Library

### PUT Knowledge Object in Running Activator

Example using a locally running activator and the kobbled hello-js knowledge object in the build/ directory.
```
curl -X PUT \
  http://localhost:8080/shelf/ark:/kobble/hello-js \
  -H 'accept-encoding: text/plain' \
  -H 'content-type: application/json' \
  --data @build/hello-js.json 
```
**OR**
```
rake activate['hello-js']
```

The response should be:
```
Object ark:/kobble/hello-js added to the shelf
```

## Test Loaded Knowledge Object

POST input data to activator with the kobject loaded
```
curl --request POST \
  --url http://localhost:8080/knowledgeObject/ark:/kobble/hello-js/result \
  --header 'content-type: application/json' \
  --header 'accept: application/json' \
  --data '{"name": "Alice"}'
```
**OR**
```
rake test['hello-js']
```

The result should be
```
{
  "result": "Hello, Alice",
  "source": "http://n2t.net//ark:/kobble/hello-js",
  "metadata": {
    "arkId": {
      "arkId": "ark:/kobble/hello-js"
    }
  }
}
```
