# Babili Ruby Client

## Usage

* Install

    ```
    gem install "babili"
    ```

* Initialize

    ```
    Babili.configure do |config|
      config.api_scheme     = <api_scheme> (default to https)
      config.api_host       = <api_host> (default to babili.spin42.me)
      config.api_port       = <api_port> (default to 443)
      config.platform_token = <platform_token>
    end
    ```

* Use

    ```
    user = Babili::Platform::User.create
    id   = user.id
    ```
