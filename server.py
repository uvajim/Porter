from flask import Flask
from plaid.model.link_token_create_request import LinkTokenCreateRequest
from plaid.model.link_token_create_request_user import LinkTokenCreateRequestUser
from plaid.model.products import Products
from plaid.model.country_code import CountryCode
import stripe

app = Flask(__name__)

access_token = None
stripe.api_key = 'sk_test_51MFUYkGUGzYa5sOrOEfdTHjwk7fu6TJAJMkWCZomKaGW1ECb9eTZqOULHyLVrtUsMlOHGodGXGxdpXTrfR7Oui9z00GYIC01UV'


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/get_plaid_token", methods=['POST'])
def get_plaid_token():
    client_id="63991a47edbcae0013f592d9"

    request = LinkTokenCreateRequest(
            products=[Products("auth")],
            client_name="Plaid Test App",
            country_codes=[CountryCode('US')],
            redirect_uri='https://domainname.com/oauth-page.html',
            language='en',
            webhook='https://webhook.example.com',
            user=LinkTokenCreateRequestUser(
                client_user_id=client_user_id
            )
        )

    response = client.link_token_create(request)

    return jsonify(response.to_dict())

@app_route("/exchange_public_token", methods=['POST'])
def exchange_public_token():
    global access_token
    public_token = request.form['public_token']
    request = ItemPublicTokenExchangeRequest(
      public_token=public_token
   )
   response = client.item_public_token_exchange(request)

    # These values should be saved to a persistent database and
    # associated with the currently signed-in user
    access_token = response['access_token']
    item_id = response['item_id']

  return jsonify({'public_token_exchange': 'complete'})

@app.route("/get_connection_token")
def token():
    token = stripe.terminal.ConnectionToken.create()
    return jsonify(secret=token.secret)

@app.route("/recieve_payment", methods=['POST'])
def create_payment_intent():
    intent = stripe.PaymentIntent.create(
        amount = request.form['amount'],
        currency='usd',
        payment_method_types=['card_present'],
        capture_method='automatic'
    )
    return jsonify(client_secret=intent.client_secret)

@app.route("/generate_location", methods=['POST'])
def generate_location():
    return stripe.terminal.Location.create(
        display_name=request.form['display_name'],
        address={
            "line1": request.form['line1'],
            "city": request.form['city'],
            "postal_code": request.form['postal_code'],
            "state": request.form['state'],
            "country": "US"
        }
    )
