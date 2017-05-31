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

## Example Use
1. Make sure an activator is running locally
2. Build all the knowledge objects
    ```
    rake kobble
    ```
3. Load the hello-js knowledge object into the activator
    ```
    rake activate['hello-js']
    ```
4. Test the hello-js knowledge object.
    ```
    rake test['hello-js']
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
