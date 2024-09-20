  GNU nano 5.6.1                                                      vm.tf                                                                 
resource "aws_instance" "first-vm" {
    count           = 1
    ami             = "ami-0dc8c969d30e42996"
    instance_type   = "t2.micro"

    tags = {
	Name        = "FirstServer"
    }
}
