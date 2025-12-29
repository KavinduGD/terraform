variable "names" {
  type = list( object({
    firstname =  string,
    lastname=string
  }))
default = [
    {
  firstname = "Kavindu",
  lastname = "Gihan"
},
 {
  firstname = "Mahinda",
  lastname = "Rajapaksha"
},
]
}



locals {
  firstnames= var.names[*].firstname
}
 

 output "firstnames" {
   value = local.firstnames
 }