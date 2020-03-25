module ItemsHelper
  def is_current_user_authorized_to_be_here(item_id)
   if !current_user.maker
    flash[:alert] = "Vous n'êtes pas autorisé à accéder à cette section"
    redirect_to root_path
   end
   item = Item.find_by(id: item_id)
   if current_user.maker.shop.id != item.shop.id
    flash[:alert] = "Vous n'êtes pas autorisé à accéder à cette section"
    redirect_to root_path
   end
  end
end
