terraform {
  required_providers {
    discord = {
      source = "Chaotic-Logic/discord"
      version = "0.0.1"
    }
  }
}

variable "discord_token" {
  type = string
  sensitive = true
}

variable "discord_server_id" {
  type = string
}

provider discord {
  token = var.discord_token
}

// data discord_member admin {
//   server_id = data.discord_server.deezcord_server.id
//   user_id   = var.admin_user_id
// }

data discord_server deezcord_server {
  server_id = var.discord_server_id
}

data discord_permission admin {
  administrator = "allow"
}

resource discord_role admin {
  name = "Admin"
  server_id = data.discord_server.deezcord_server.id
  permissions = data.discord_permission.admin.allow_bits
  // color = data.discord_color.blue.dec
  hoist = true
  mentionable = true
  position = 1
}

// resource discord_server deezcord_server {
//   name = "Deezcord Test"
//   region = "singapore"
//   default_message_notifications = 0
//   // icon_data_uri = data.discord_local_image.logo.data_uri
// }

resource discord_category_channel public {
  name = "public"
  position = 0
  server_id = data.discord_server.deezcord_server.id
}

resource discord_category_channel members {
  name = "members"
  position = 0
  server_id = data.discord_server.deezcord_server.id
}

resource discord_text_channel welcome {
  name = "welcome"
  topic = "The welcome channel"
  position = 0
  category = discord_category_channel.public.id
  server_id = data.discord_server.deezcord_server.id
}

resource discord_text_channel gaming {
  name = "gaming"
  topic = "The Gaming channel"
  position = 1
  category = discord_category_channel.members.id
  server_id = data.discord_server.deezcord_server.id
}

resource discord_text_channel bots {
  name = "bots"
  topic = "The bots channel"
  position = 2
  category = discord_category_channel.members.id
  server_id = data.discord_server.deezcord_server.id
}

// resource discord_invite welcome {
//   channel_id = discord_text_channel.welcome.id
//   max_age = 3600
// }

// resource discord_member_roles admin {
//   count = var.admin_user_invited ? 1 : 0
//   user_id = data.discord_member.admin.id
//   server_id = data.discord_server.deezcord_server.id
//   role {
//     role_id = discord_role.admin.id
//   }
//   // role {
//   //     role_id = var.role_id_to_always_remove
//   //     has_role = false
//   // }
// }

// output invite {
//   value = "https://discord.gg/${discord_invite.welcome.id}"
// }

// Pulling existing resource with terraform import [resource] [ID]

// terraform import discord_category_channel.text_channels xxxxxxxxxxxxxxxxxxxxx
resource discord_category_channel text_channels {
  name = "Text Channels"
  server_id = data.discord_server.deezcord_server.id
}
