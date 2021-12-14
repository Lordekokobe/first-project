resource "aws_vpc" "myvpc" {
  cidr_block = "var.myvpccidr"
}
resource "aws_subnet" "mysubnet" {
   vpc_id = "aws_vpc.myvpc.id"
   cidr_block = "var.mysubnetcidr"
   availability_zone = "var.az"
   tags {
     Name = "mysubnet"
   }
}
resouce "aws_internet_gateway"  "myigw"{
   vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
  }

}
  resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table_association" "mypublicrt" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myrt.id
}
resource "aws_route" "r" {
  route_table_id            = aws_route_table.myrt.id
  destination_cidr_block    = "0.0.0.0/0"
}
depend_0n =[
  aws_internet_gateway.myigw
]