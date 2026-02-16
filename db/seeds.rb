Domain::Customer::Vehicle.delete_all
Domain::Customer::Customer.delete_all

clientes = [
  { name: "Luke Skywalker", document_number: "38830424048", email: "luke@jedi.com", phone: "+55 (11) 91234-5678" },
  { name: "Leia Organa", document_number: "49859924023", email: "leia@rebellion.org", phone: "+55 (21) 99876-5432" },
  { name: "Han Solo", document_number: "93715993081", email: "han@falcon.space", phone: "+55 (31) 98765-4321" },
  { name: "Darth Vader", document_number: "10457656000", email: "vader@empire.gov", phone: "+55 (41) 99999-0000" }
].map { |attrs| Domain::Customer::Customer.create!(attrs) }

veiculos = []
veiculos << Domain::Customer::Vehicle.create!(customer_id: clientes[0].id, license_plate: "ABC1234", brand: "Toyota", model: "Corolla", year: 2020)
veiculos << Domain::Customer::Vehicle.create!(customer_id: clientes[0].id, license_plate: "DEF5678", brand: "Ford", model: "Mustang", year: 2018)
veiculos << Domain::Customer::Vehicle.create!(customer_id: clientes[1].id, license_plate: "GHI9012", brand: "Honda", model: "Civic", year: 2019)
veiculos << Domain::Customer::Vehicle.create!(customer_id: clientes[2].id, license_plate: "JKL3456", brand: "Chevrolet", model: "Camaro", year: 2021)
veiculos << Domain::Customer::Vehicle.create!(customer_id: clientes[3].id, license_plate: "EMP0001", brand: "Imperial", model: "Destroyer", year: 2022)
