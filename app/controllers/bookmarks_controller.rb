class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])  # Trouver la liste associée
    @bookmark = Bookmark.new             # Initialiser un nouveau signet
  end

  def create
    @list = List.find(params[:list_id])  # Trouver la liste associée
    @bookmark = @list.bookmarks.build(bookmark_params) # Associer le signet à la liste

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Le signet a été ajouté avec succès.'
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Le signet a été supprimé avec succès.'
  end

  private

  # Strong parameters pour sécuriser les attributs du signet
  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
