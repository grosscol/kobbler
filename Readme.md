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

## Test Loaded Knowledge Object

1. POST input data to activator with the kobject loaded
1. Results
