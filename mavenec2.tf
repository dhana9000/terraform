resource "aws_instance" "maven" {
    ami= "ami-04b9e92b5572fa0d1"
    instance_type= "t2.micro"
    key_name= "jenkins"
    security_groups= ["launch-wizard-1"]
    tags = {
        "Name" = "maven"
    }
    connection {
        type= "ssh"
        user= "ubuntu"
        host= "${aws_instance.maven.public_ip}"
        private_key= "${file("./jenkins.pem")}"
    }
    provisioner "remote-exec"{
        inline= [
            "sudo apt-get update",
            "sudo apt-get install openjdk-8-jdk -y",
            "sudo apt-get install maven -y"
        ]
    }
}
