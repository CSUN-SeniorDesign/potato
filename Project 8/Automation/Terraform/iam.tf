# Creating group administrators
resource "aws_iam_group" "potatoadmin" {
    name = "potatoadmin"
}

# Creating iam policy to give administrators access 
resource "aws_iam_policy_attachment" "potatoadmin-attach" {
    name = "potatoadmin-attach"
    groups = ["${aws_iam_group.potatoadmin.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# user

# create users
resource "aws_iam_user" "adminusr1" {
    name = "DanielH"
}
resource "aws_iam_user" "adminusr2" {
    name = "ShahidK"
}
resource "aws_iam_user" "adminusr3" {
    name = "TonnyW"
}
# add users to a group :)

resource "aws_iam_group_membership" "potatoadmin-users" {
    name = "potatoadmin-users"
    users = [
        "${aws_iam_user.adminusr1.name}",
        "${aws_iam_user.adminusr2.name}",
		"${aws_iam_user.adminusr3.name}",

    ]
    group = "${aws_iam_group.potatoadmin.name}"
}