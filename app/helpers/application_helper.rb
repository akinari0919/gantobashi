module ApplicationHelper
  def default_meta_tags
    {
      site: 'メンチキッター',
      title: 'メンチキッター 〜ガン飛ばしてちょいワル気分〜',
      reverse: true,
      charset: 'utf-8',
      description: 'カメラに向かってガン飛ばすだけ！「たまにはちょっと悪ぶりたい(-"-#)」そんな少しやんちゃな想いを叶えるサービスです◎',
      keywords: 'メンチキッター,ガン飛ばし,ちょいワル気分',
      canonical: request.original_url,
      separator: '|',
      viewport: 'width=device-width,initial-scale=1,viewport-fit=cover',
      icon: [
        { href: image_url('180smart_icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
        { href: image_url('192smart_icon.png'), rel: 'icon', sizes: '192x192', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('site_image.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
      }
    }
  end
end
