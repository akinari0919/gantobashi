module AwsRecognition
  extend ActiveSupport::Concern

  def check_face
    credentials = Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
    photo = Base64.decode64(params[:image])
    client = Aws::Rekognition::Client.new credentials: credentials
    attrs = {
      image: { 
        bytes: photo
      },
      attributes: ['ALL']
    }

    response = client.detect_faces attrs
  end
end
