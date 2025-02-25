##
# Classe Controller que é responsável por visualizar o sistema de usuários
# Apenas o administrador tem permissão para acessar a lista de usuários

class UsersController < ApplicationController

  before_action :signed_in?
  before_action :is_admin?, only: [:show]

  ##
  # GET	/users/show
  # Controller que lista todos os usuários do sistema
  # Assim como é responsável pela ordenação crescente e decrescente
  # e por realizar buscas no model User 
  def show
    ##
    # Variável de instância  @q recebe os parametros oriundos do search_form
    # @users recebe  o resultado da busca tanto para ordenação, quanto da busca
    # realizada no model User referente ao request do usuário
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  ##
  # Verifica se existe um usuário logado
  # Recebe como parâmetro o usuário (current_user)
	# retorna true se existe um usuário logado
  def signed_in?
    if current_user
        true
    else
      flash[:danger] = "Você não pode acessar essa página"
      return redirect_to '/'
    end
  end

  ##
  # Verifica se o usuário logado é administrador
  # Recebe como parâmetro o usuário (current_user)
	# retorna true se o usuário é administrador, caso contrário redireciona para a página inicial além de mostrar um pop up
  def is_admin?
      if current_user.is_admin
        true
      else
        flash[:danger] = "Você não pode acessar essa página"
        return redirect_to '/'
      end
  end
end
