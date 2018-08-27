class SessionsController < ApplicationController
skip_before_action :authenticate_user, only: :create

def create
  resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = "40E3M1I2OXGEEWLQD3UNOSFYAGYOZIOJRDC0V0FJS0LTTVD4"
    req.params['client_secret'] = "3RE5NNILSNXVOMSGIVJASU1ZRCM4K0Y4MTPAMUSX0Q1WIZ2P"
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end
 
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end
