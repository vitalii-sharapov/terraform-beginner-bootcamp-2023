terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "Vitalii-Sharapov"
  
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

module "home_generic_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.generic.public_path
  content_version = var.generic.content_version
}

resource "terratowns_home" "home" {
  name = "Let's check this out!"
  description = <<DESCRIPTION
Generic fun page for missingo.
DESCRIPTION
  domain_name = module.home_generic_hosting.domain_name
  #domain_name = "*.cloudfront.net"
  town = "missingo"
  content_version = var.generic.content_version
}

module "home_factorio_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.factorio.public_path
  content_version = var.factorio.content_version
}

resource "terratowns_home" "home_factorio" {
  name = "Let's play Factorio!"
  description = <<DESCRIPTION
Factorio is a construction and management simulation game developed and published by Czech studio Wube Software.
DESCRIPTION
  domain_name = module.home_factorio_hosting.domain_name
  #domain_name = "*.cloudfront.net"
  town = "gamers-grotto"
  content_version = var.factorio.content_version
}

module "home_music_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.music.public_path
  content_version = var.music.content_version
}

resource "terratowns_home" "home_music" {
  name = "Let's listen to some good music!"
  description = <<DESCRIPTION
Click to see more fun =D.
DESCRIPTION
  domain_name = module.home_music_hosting.domain_name
  #domain_name = "*.cloudfront.net"
  town = "melomaniac-mansion"
  content_version = var.music.content_version
}

module "home_video_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.video.public_path
  content_version = var.video.content_version
}

resource "terratowns_home" "home_video" {
  name = "Let's watch something interesting!"
  description = <<DESCRIPTION
Click to see some cool video!
DESCRIPTION
  domain_name = module.home_video_hosting.domain_name
  #domain_name = "*.cloudfront.net"
  town = "video-valley"
  content_version = var.video.content_version
}

module "home_canada_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.canada.public_path
  content_version = var.canada.content_version
}

resource "terratowns_home" "home_canada" {
  name = "Let me show you some: 'Oh Canada!'"
  description = <<DESCRIPTION
Canada is awesome!!!.
DESCRIPTION
  domain_name = module.home_canada_hosting.domain_name
  #domain_name = "*.cloudfront.net"
  town = "the-nomad-pad"
  content_version = var.canada.content_version
}