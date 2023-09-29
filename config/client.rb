# Interface for AEM requests
class Client
  def self.get(url, options = {})
    options[:username] = aem_auth_user.to_s
    options[:password] = aem_auth_pass.to_s

    execute_request(url, :get, options)
  end

  def self.put(url, options = {})
    options[:username] = aem_auth_user.to_s
    options[:password] = aem_auth_pass.to_s

    execute_request(url, :put, options)
  end

  def self.execute_request(url, method, options = {})
    request = Typhoeus::Request.new(
      url,
      method: method,
      headers: { 'content-type' => 'application/json' },
      **options
    )

    handle_response(request)
  end

  def self.handle_response(request)
    request.run
    handle_response_without_run(request)
  end

  def self.handle_response_without_run(request)
    response = request.response
    response_body = response.body
    is_json_response = response.headers['content-type'] == 'application/json'
    response_body = JSON.parse(response_body) if is_json_response

    response_body
  end

  def self.aem_auth_user
    ENV.fetch('AEM_AUTH_USER')
  end

  def self.aem_auth_pass
    # The value of this environment variable contains special characters.
    # In order to escape those characters, the value was surrounded with single quotes.
    # Тhis way the quotes become a part of the value and they need to be removed.
    ENV.fetch('AEM_AUTH_PASS').delete_prefix("'").delete_suffix("'")
  end
end