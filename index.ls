fs = require "fs"
Discord = require "discord.js"
shuffle = require "shuffle-array"

token = fs.readFileSync 'token', 'UTF-8' .replace /\n$/, ""

client = new Discord.Client!

client.on 'ready', ->
	console.log "Logged in as #{client.user.tag}"

elect = (guild, role-name) ->
	candidates = guild.roles.find (.name == role-name) .members

	moderators = shuffle candidates.array!

	moderators = moderators.slice -7

	moderators

client.on 'message', (message) ->
	if message.content == '!tirage'
		try
			ListEmbed = new Discord.RichEmbed!
				.setTitle("Modérateurs tirés au sort")
				.setDescription(
					elect(message.guild, 'VM')
						.map (e) ->
							"  - " + e.user.username
						.join "\n"
				)

			message.channel.send ListEmbed
		catch e
			message.channel.send "I don’t feel so well inside."
			console.log e

client.login token

