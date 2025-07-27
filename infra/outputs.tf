output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_endpoint" {
  value = module.eks.cluster_endpoint
}

output "frontend_bucket" {
  value = module.s3.bucket_name
}

output "dns_record" {
  value = module.route53.record_fqdn
}
