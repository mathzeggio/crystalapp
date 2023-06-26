# **Multiverse Travels Booker**
This document provides documentation for the Multiverse Travels Booker, which allows users to retrieve travel plans and customize the response using headers. The API is developed using Crystal language and utilizes the following frameworks and technologies:

- **Framework**: Kemal
- **ORM**: Jennifer
- **Database**: PostgreSQL
- **API Integration**: Rick and Morty API with GraphQL

The API is deployed using Docker Compose and runs on port 3000.

## **Pre requisites**
Make sure you have the following software installed on your machine before running the API:

- Docker
- Docker Compose

## **Getting Started**
To start the API server, follow these steps:

1. Clone the repository:

```shell
git clone https://github.com/example/travel-plans-api.git
```

2. Change to the project directory:

```shell
cd travel-plans-api
```

3. Build and run the Docker containers:

```shell
docker-compose up
```
This will start the API server and make it accessible at **`http://localhost:3000`**.

## Endpoints
The API provides the following endpoints:

## **Create Travel Plan**
- **URL**: /travel-plans
- **Method**: POST
- **Headers**:
- **Content-Type**: application/json
- **Body**: **"travel_stops"**: An array of integers representing the IDs of the travel locations.
This endpoint allows you to create a new travel plan by sending an array of location IDs. The system will assign an ID to the plan and return the updated array with the assigned ID.

Example request body:

```json
{
   "travel_stops": [1, 2, 3]
}
```
Example response:

```json
{
    "id": 1,
    "travel_stops": [1, 2, 3]
}
```


### **Get All Travel Plans**
- **URL: /travel-plans**
- Method: GET
- Headers:
  - expand: Set to true to include additional details for each travel stop.
  - optimize: Set to true to organize the travel stops based on popularity.
- **Content-Type**: application/json

This endpoint returns a list of travel plans. By default, the response contains minimal information for each plan:

Example response:

```json

[
    {
        "id": 2,
        "travel_stops": [1, 2, 3]
    }
]
```
Expand Travel Stops

To retrieve more details about each travel stop, include the **expand** header in the request and set it to **true**. The response will include an array of travel stops with additional information:

Example response with expanded travel stops:

```json
[
    {
        "id": 2,
        "travel_stops": [
            {
                "id": 1,
                "name": "Earth (C-137)",
                "dimension": "Dimension C-137",
                "type": "Planet"
            },
            {
                "id": 2,
                "name": "Abadango",
                "dimension": "unknown",
                "type": "Cluster"
            },
            {
                "id": 3,
                "name": "Citadel of Ricks",
                "dimension": "unknown",
                "type": "Space station"
            }
        ]
    }
]
```
Optimize Travel Stops

To organize the travel stops based on popularity, include the optimize header in the request and set it to true. The response will contain the travel stops sorted in ascending order of popularity, first by galaxy and then by individual location.

### **Get a Travel Plan By Id**
- **URL: /travel-plans/:id*
- **Method: GET**
- Headers:
  - expand: Set to true to include additional details for each travel stop.
  - optimize: Set to true to organize the travel stops based on popularity.
- **Content-Type**: application/json
 
This endpoint retrieves a specific travel plan based on the provided ID.

Example URL: **/travel-plans/2**

Example response:

```json
    {
        "id": 2,
        "travel_stops": [1, 2, 3]
    }
```
Expand Travel Stops

To retrieve more details about each travel stop, include the **expand** header in the request and set it to **true**. The response will include an array of travel stops with additional information:

Example response with expanded travel stops:

```json
    {
        "id": 2,
        "travel_stops": [
            {
                "id": 1,
                "name": "Earth (C-137)",
                "dimension": "Dimension C-137",
                "type": "Planet"
            },
            {
                "id": 2,
                "name": "Abadango",
                "dimension": "unknown",
                "type": "Cluster"
            },
            {
                "id": 3,
                "name": "Citadel of Ricks",
                "dimension": "unknown",
                "type": "Space station"
            }
        ]
    }
```
Optimize Travel Stops

To organize the travel stops based on popularity, include the optimize header in the request and set it to true. The response will contain the travel stops sorted in ascending order of popularity, first by galaxy and then by individual location.

## **Update Travel Plan**
- **URL**: /travel-plans/:id
- **Method**: PUT
- **Headers**:
- **Content-Type**: application/json
- **Body**: An object containing the updated travel stops.

This endpoint allows you to update the travel stops of a specific travel plan based on the provided ID. Send an object with the travel_stops property containing the new array of location IDs.
Example URL: **/travel-plans/2**

**Example request:**
```json
{
    "travel_stops": [4, 9, 6]
}
```
Example response:

```json
{
    "id": 4,
    "travel_stops": [4, 9, 6]
}
```

## **Append new travel stops**
- **URL**: /travel-plans/:id/append
- **Method**: POST
- **Headers**:
- **Content-Type**: application/json
- **Body**: An array of ints containing new travel stops.

This endpoint allows you to add new travel stops of a specific travel plan based on the provided ID. Send an object with the travel_stops property containing the new array of location IDs.
Example URL: **/travel-plans/2/append**

**Example request:**
```json
{
    "travel_stops": [4, 9, 6]
}
```
Example response:

```json
{
    "id": 4,
    "travel_stops": [1, 2, 3, 4, 9, 6]
}
```

## **Delete Travel Plan**
- **URL**: /travel-plans/:id
- **Method**: DELETE
- **Headers**:
- 
This endpoint allows you to delete a specific travel plan based on the provided ID.

**Example URL:** /travel-plans/4

No response body is returned for the delete operation.

## Contributors
The following individuals have contributed to the development of the Travel Plans API:

[Matheus Zeggio](https://github.com/mathzeggio)

If you would like to contribute to this project, please fork the repository and submit a pull request with your changes.
