# Colin's Knowledge Objects

## Description
Knowledge Grid Knowledge Objects for development with the Landis-Lewis Lab.

## Setup
```
bundle install
```

## Use
1. Make directory under src/
1. Write metadata.yml
1. Write payload
1. Run default rake task
    ```
    rake
    ```

## Loading Knowledge Objects

* PUT request to Activator
* Add to shelf directory of Activator
* Knowledge Grid Library ("Kaleb")

### PUT Knowledge Object

Example using a locally running activator and the kobbled hello-js knowledge object in the build/ directory.
```
curl -X PUT \
  http://localhost:8080/shelf/ark:/kobble/hello-js \
  -H 'accept-encoding: text/plain' \
  -H 'content-type: application/json' \
  --data @build/hello-js.json 
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
