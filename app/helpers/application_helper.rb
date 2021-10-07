module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Tech Train"
    if page_title.empty?
      base_title
    else
      page_title
		end
  end
end
