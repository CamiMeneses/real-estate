# README

Clone this repository to use the real estate service. Run rails server and check the diiferent endpoints to see their response:

**INDEX** GET http://localhost:3000/buildings

**SHOW** GET http://localhost:3000/buildings/:id

**CREATE** POST http://localhost:3000/buildings

**UPDATE** PUT http://localhost:3000/buildings/:id

**DELETE** DELETE http://localhost:3000/buildings/:id

For CREATE and UPDATE action you can use the following body:

{

"building": {

name: "Casa Morada",

type_cd: "land",

"street": "Avenida Jimenez",

"external_number": "ASD123",

"internal_number": "123123",

"neighborhood": "Salitre",

"city": "Bogotá",

"country": "CO",

"rooms": 2,

"bathrooms": 0,

"comments": "Casa Linda"

}

}

**Valid data:**

- **name:**  1 to 128 characters. Required.
- **type_cd:** house, department, land, commercial_ground. Required.
- **street:** 1 to 128 characters. Required.
- **external_number:** 1 to 12 characters. Only alphanumerics and dash (-). Required.
- **internal_number:** Only alphanumerics, dash (-) and blank spaces. Required.
- **neighborhood:** 1 to 128 characters. Required.
- **city:** 1 to 64 characters. Required.
- **country:** Valid options: any under ISO 3166- Alpha2 (Two characters). Otherwise: invalid. Required.
- **rooms:** Required.
- **bathrooms**: Can be zero only if "land" or "commercial_ground". Can have decimals. Required.
- **comments:** 1 to 128 characters. Not required.

For unit tests run **rspec**
