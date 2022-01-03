module ApplicationHelper
  def default_meta_tags
    {
      site: 'メンチキッター',
      title: 'メンチキッター',
      reverse: true,
      charset: 'utf-8',
      description: 'ちょっと悪ぶりたい人の為のガン飛ばしアプリ',
      keywords: 'メンチキッター,ガン飛ばし',
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
        image: image_url('logo.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@runmizzo',
      }
    }
  end
end
