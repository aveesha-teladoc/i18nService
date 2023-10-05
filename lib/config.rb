class Config
  LOCAL_AEM_ENV = 'local'

  def self.aem_env
    ENV.fetch('AEM_ENV')
  end

  def self.cms_fetch_from_author_aem
    ENV.fetch('CMS_FETCH_FROM_AUTHOR_AEM', 'false') == 'true'
  end

  def self.author_aem_api_host
    aem_env == LOCAL_AEM_ENV ? local_author_aem_api_host : "https://author-teladoc-#{aem_env}.adobecqms.net"
  end

  def self.dispatcher_aem_api_host
    return author_aem_api_host if cms_fetch_from_author_aem

    aem_env == LOCAL_AEM_ENV ? local_publish_aem_api_host : "https://teladoc-#{aem_env}.adobecqms.net"
  end

  def self.local_author_aem_api_host
    'http://localhost:4502'
  end

  def self.local_publish_aem_api_host
    'http://localhost:4503'
  end
end
