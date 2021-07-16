class Api::JsonApiController < ApplicationController
  def render_json(json, status: 200)
    render status: status, plain: json.to_json, content_type: 'application/json'
  end
end
