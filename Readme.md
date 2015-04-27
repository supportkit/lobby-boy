# Lobby Boy

An open-source project that demonstrates how you can use [SupportKit](http://supportkit.io) to offer products and services to your users through messaging.

When you offer a product or service to your users this way, the offer is displayed in an interactive chat bubble in the messaging UI. With a single tap on the bubble's "Buy" button you can charge a credit card and take an order. It's effortless.

Lobby Boy demonstrates a simple workflow modelled after services like Magic, Cloe, Ask Alexis and more. It even works with Stripe to process payments! You can use Lobby Boy "out of the box" to build your own on-demand, conversational commerce business in minutes.

## Configuring Lobby Boy

You can compile Lobby Boy from source and chat with members of the team who hacked on it. (However, we won't actually be able to ship you anything or process real credit cards!) 

If you want to configure Lobby Boy for your own uses, it only takes a few minutes. You'll only need to modify a few constants in LBStripeCharger.m

1. Sign up for an account at [SupportKit.io](https://app.supportkit.io/signup)
2. Set kSupportKitAppToken (in LBStripeCharger.m) to the app token you got in step 1.
3. Sign up for a Stripe account and get set your publishable key as the constant kStripePublishableKey.
4. Hop over to our [backend repository](https://github.com/supportkit/lobby-boy-stripe-backend) and hit the "Deploy to Heroku" button to instantly configure and launch the Lobby Boy backend with your Stripe secret key.
5. Specify the URL of your newly deployed backend as the value of the constant kPaymentServerBaseUrl.

You're ready to go! We'd love to hear your feedback, reach us [@supportkit](http://twitter.com/supportkit) or hello@supportkit.io

## Offering a product or service

Offering a product or service to your users is easy, just use the `!offer` command in Slack and your offer will appear in the user's conversation with the option to buy or view more info.

1. Configure a [Slack integration](http://docs.supportkit.io/#slack) for your SupportKit app.
2. When speaking to one of your users, use the `/sk !offer` command with the following syntax: `/sk !offer [price] [image-url] [product-info-url] [product name]` For example: `!offer 129.99 http://www.selectism.com/files/2014/03/budapest-nose-2014-01-630x420.jpg http://google.com Air de Panache`
