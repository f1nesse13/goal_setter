class GoalsController < ApplicationController
  before_action :redirect_if_logged_out

  def index
    @goals = current_user.goals
    render :index
  end

  def show
    @goal = Goal.find(params[:id])

    if @goal["public"] == true || @goal.user_id == current_user.id
      render :show
    else
      flash[:errors] = ["This goal is marked private"]
      redirect_to goals_url
    end
  end

  def new
    @goal = Goal.new()
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      flash[:notice] = ["Goal successfully created"]
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.user_id == current_user.id
      @goal.update(completed: !@goal.completed)
      redirect_to goals_url
    else
      flash[:errors] = ["You can't complete other users goals"]
      redirect_back
    end
  end

  def destroy
    @goal = Goal.find(params[:id])

    if @goal.user_id == current_user.id
      @goal.destroy
      redirect_to goals_url
    else
      flash[:errors] = ["You can't delete other users goals"]
      redirect_to goals_url
    end
  end

  private

  def goal_params
    params[:goal][:public] = params[:goal][:public] == "private" ? false : true
    params[:goal][:completed] = params[:goal][:completed] == "complete" ? true : false
    params.require(:goal).permit(:title, :details, :public, :completed)
  end
end
