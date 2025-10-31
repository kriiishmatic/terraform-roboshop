resource "aws_ssm_parameter" "sg_ids" {
    count = length(var.sg_name)
  name = "/${var.project}/${var.environment}/${var.sg_name[count.index]}_sg_ids"
  type = "String"
  value =  module.sg-roboshop[count.index].sg_id
}