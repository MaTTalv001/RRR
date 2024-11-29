module ApplicationHelper
  def default_meta_tags
    {
      site: 'Reality Reflections',
      separator: '|',
      description: 'あるあるを寄せ合うSNS',
      keywords: 'Reality Reflections,あるある,SNS',
      canonical: request.original_url,
      og: {
        site_name: 'Reality Reflections',
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image'
      }
    }
  end
end