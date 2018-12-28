class XeroSessionController < ApplicationController

	before_filter :get_xero_client

  def new
    request_token = @xero_client.request_token(:oauth_callback => 'https://fourfivecbd.com/xero_session/create')
    session[:request_token] = request_token.token
    session[:request_secret] = request_token.secret

    redirect_to request_token.authorize_url
  end

  def create
    @xero_client.authorize_from_request(
        session[:request_token],
        session[:request_secret],
        :oauth_verifier => params[:oauth_verifier] )

    session[:xero_auth] = {
        :access_token => @xero_client.access_token.token,
        :access_key => @xero_client.access_token.secret }

    session.data.delete(:request_token)
    session.data.delete(:request_secret)
  end

  def destroy
    session.data.delete(:xero_auth)
  end

private

  def get_xero_client
    @xero_client = Xeroizer::PublicApplication.new(ENV['XERO_KEY'], ENV['XERO_SECRET'])

    # Add AccessToken if authorised previously.
    if session[:xero_auth]
      @xero_client.authorize_from_access(
        session[:xero_auth][:access_token],
        session[:xero_auth][:access_key] )
    end
  end
end
