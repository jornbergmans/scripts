#!/usr/bin/env python3

import discord

TOKEN = 'NjAzMTQxMTQ5NjM2Njg5OTIw.XTbM3w.2VE73TyajD6kg0h2yh0KDYUAZog'

client = discord.Client()

@client.event
async def on_message(message):
    if message.author.id == client.user.id:
        return

    if message.content.startswith('!hello'):
        msg = 'Hello {0.author.mention}'.format(message)
        await message.channel.send(msg)

@client.event
async def on_ready():
    print('Logged in as')
    print(client.user.name)
    print(client.user.id)
    print('------')

client.run(TOKEN)
