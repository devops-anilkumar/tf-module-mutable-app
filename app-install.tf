resource "null_resource" "app" {
 //  triggers = {var = var.APP_VERSION}   # WHENEVER THERE IS A CHANGE IN THE APP VERSION IT TRIGGERS
 //triggers = { always = true }   
  triggers     = {  timestamp =    timestamp() }  // This ENSURES IT will run all the time

count        = var.SPOT_INSTANCE_COUNT + var.OD_INSTANCE_COUNT

 #DECLEARING THE REMOTE PROVISIONER INSIDE THE RESOURCE 
    provisioner "remote-exec" {
    
    connection {              //establishes connectivity to the created machine
    type     = "ssh"
    user     = local.SSH_USER
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_IPS, count.index)
  }
    inline = [
     // "ansible-pull -U https://github.com/devops-anilkumar/ansible.git robot-pull.yml -e ENV=dev -e COMPONENT=mongodb"
     "ansible-pull -U https://github.com/devops-anilkumar/ansible.git robot-pull.yaml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT} -e APP_VERSION=${var.APP_VERSION}"
     
    ]
  }
}
