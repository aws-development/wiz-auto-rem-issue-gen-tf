resource "aws_iam_policy" "policy" {
  name        = "wiz_iam_issue_poc_policy"
  path        = "/"
  description = "Wiz dummy  poc iam policy to policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "cloudformation:SetStackPolicy",
                "cloudformation:CancelUpdateStack",
                "cloudtrail:StartLogging",
                "cloudtrail:StopLogging",
                "cloudtrail:UpdateTrail",
                "cloudformation:UpdateTerminationProtection",
                "cloudformation:SignalResource",
                "iam:UpdateRoleDescription",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "cloudformation:CreateChangeSet",
                "iam:PutRolePolicy",
                "cloudformation:DeleteChangeSet",
                "cloudformation:ContinueUpdateRollback",
                "iam:DetachRolePolicy",
                "cloudformation:CreateStack",
                "cloudtrail:AddTags",
                "cloudtrail:DeleteTrail",
                "iam:DeleteRolePolicy",
                "cloudformation:DeleteStack",
                "cloudformation:UpdateStack",
                "iam:DeleteServiceLinkedRole",
                "cloudformation:ExecuteChangeSet",
                "cloudtrail:RemoveTags",
                "iam:UpdateSAMLProvider",
                "iam:DeleteSAMLProvider",
                "iam:DeletePolicy",
                "iam:CreatePolicyVersion",
                "iam:DeletePolicyVersion",
                "iam:SetDefaultPolicyVersion",
                "iam:UpdateAssumeRolePolicy",
                "iam:UpdateRole"
            ],
            "Resource": [
                "arn:aws:cloudformation:*:*:stack/StackSet-DCSLayer0*/*",
                "arn:aws:cloudtrail:*:*:trail/DCSCentralizedLogging",
                "arn:aws:iam::*:role/DCSLayer0/*",
                "arn:aws:iam::*:role/AWSCloudFormationStackSetExecutionRole",
                "arn:aws:iam::*:role/CloudabilityRole",
                "arn:aws:iam::*:saml-provider/AzureAD",
                "arn:aws:iam::*:policy/DeloittePermissionsBoundaryPolicy",
                "arn:aws:iam::*:policy/DeloitteConnectedEnvironmentBoundaryPolicy",
                "arn:aws:iam::*:policy/DenyDeloittePlatformModificationPolicy",
                "arn:aws:iam::*:policy/DCS*",
                "arn:aws:iam::*:policy/EC2SSMAgentMonitoring",
                "arn:aws:iam::*:role/EC2SSMAgentProfile*",
                "arn:aws:iam::*:role/dcs-ssm-agent-monitoring-role",
                "arn:aws:iam::*:policy/dcs-ssm-agent-monitoring-policy",
                "arn:aws:iam::*:policy/dcs-aws-ssm-agent-monitoring-policy",
                "arn:aws:iam::*:policy/dcs-aws-ssm-agent-monitoring-role",
                "arn:aws:iam::*:policy/DCSSSMAccessPolicy",
                "arn:aws:iam::*:policy/DCSSSMAccessRole"
            ],
            "Effect": "Deny",
            "Sid": "DenyPlatformModification"
        },
        {
            "Action": [
                "iam:DeleteAccountPasswordPolicy",
                "iam:UpdateAccountPasswordPolicy"
            ],
            "Resource": "*",
            "Effect": "Deny",
            "Sid": "DenyPasswordPolicyModification"
        },
        {
            "Action": [
                "events:DeleteRule",
                "events:EnableRule",
                "events:RemoveTargets",
                "events:DisableRule",
                "events:PutEvents",
                "events:PutTargets",
                "events:PutRule",
                "events:RemovePermission",
                "events:PutPermission"
            ],
            "Resource": "arn:aws:events:*:*:rule/deloittecloud-*",
            "Effect": "Deny",
            "Sid": "DenyDisablingCWEvents"
        },
        {
            "Action": [
                "config:DeleteDeliveryChannel",
                "config:PutConfigurationRecorder",
                "config:StopConfigurationRecorder",
                "config:StartConfigurationRecorder",
                "config:PutDeliveryChannel",
                "config:DeleteConfigurationRecorder"
            ],
            "Resource": "*",
            "Effect": "Deny",
            "Sid": "DenyDisablingConfig"
        },
        {
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": [
                        "ap-southeast-3",
                        "eu-central-2",
                        "eu-south-2",
                        "me-central-1",
                        "ap-south-2",
                        "ap-southeast-4"
                    ]
                }
            },
            "Resource": "*",
            "Effect": "Deny",
            "NotAction": [
                "iam:Get*",
                "iam:List*",
                "organizations:*",
                "route53:*",
                "budgets:*",
                "waf:*",
                "cloudfront:*",
                "globalaccelerator:*",
                "importexport:*",
                "support:*",
                "aws-portal:*",
                "sts:*",
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation",
                "directconnect:*",
                "cur:*",
                "artifact:*",
                "resource-groups:*",
                "tag:*",
                "trustedadvisor:*",
                "chime:*"
            ],
            "Sid": "DenyAccessToRegions"
        },
        {
            "Action": [
                "s3:DeleteObject",
                "s3:DeleteBucket",
                "s3:PutObject",
                "s3:DeleteObjectVersion",
                "s3:DeleteBucketOwnershipControls",
                "cloudtrail:DeleteTrail",
                "cloudtrail:StopLogging",
                "cloudtrail:UpdateTrail"
            ],
            "Resource": [
                "arn:aws:s3:::dcs-centralized-logging-bucket-*",
                "arn:aws:cloudtrail:*:*:trail/dcs-centralized-cloudtrail-*"
            ],
            "Effect": "Deny",
            "Sid": "DenyLoggingModification"
        },
        {
            "Action": [
                "ec2:AssociateAddress",
                "ec2:CreateNatGateway",
                "ec2:CreateInternetGateway",
                "ec2:AttachInternetGateway",
                "ec2:AttachNatGateway",
                "ec2:AssociateVpcCidrBlock"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Deny",
            "Sid": "DenySensitiveNetworkingEvents"
        },
        {
            "Action": [
                "ec2:CreateVpcPeeringConnection",
                "ec2:AcceptVpcPeeringConnection",
                "ec2:AcceptTransitGatewayPeeringAttachment",
                "ec2:CreateTransitGatewayPeeringAttachment",
                "ec2:DeleteTransitGatewayPeeringAttachment",
                "ec2:DeleteVpcPeeringConnection",
                "ec2:ModifyVpcPeeringConnectionOptions",
                "ec2:RejectTransitGatewayPeeringAttachment",
                "ec2:RejectVpcPeeringConnection"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Deny",
            "Sid": "DenyVPCPeering"
        },
        {
            "Action": [
                "ec2:DisableEbsEncryptionByDefault"
            ],
            "Resource": "*",
            "Effect": "Deny",
            "Sid": "DenyDisableEbsEncryptionByDefault"
        },
        {
            "Action": [
                "config:DeleteAggregationAuthorization",
                "config:DeleteConfigRule"
            ],
            "Resource": [
                "arn:aws:config:*:*:aggregation-authorization/311648320290/*",
                "arn:aws:config:*:*:aggregation-authorization/405419960913/*",
                "arn:aws:config:*:*:aggregation-authorization/614630089683/*"
            ],
            "Effect": "Deny",
            "Sid": "DenyDeleteConfigRule"
        },
        {
            "Action": [
                "ssm:DeleteResourceDataSync",
                "ssm:UpdateResourceDataSync"
            ],
            "Resource": "arn:aws:ssm:*:*:resource-data-sync/DCS-Inventory*",
            "Effect": "Deny",
            "Sid": "SSMInventoryDeny"
        },
        {
            "Action": "*",
            "Resource": "*",
            "Effect": "Allow",
            "Sid": "AllowEverythingElse"
        },
        {
            "Action": [
                "organizations:LeaveOrganization"
            ],
            "Resource": "*",
            "Effect": "Deny",
            "Sid": "DenyLeavingOrganizatoin"
        }
    ]
}
)
}
