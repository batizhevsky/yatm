require 'spec_helper'

describe TasksController do

  before(:each) do
    request.env["HTTP_REFERER"] = 'http://test.host/'
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end

  let(:task_attributes) { FactoryGirl.attributes_for :task }
  let(:task) { Task.create(task_attributes) }

  describe "GET index" do
    it "as guest" do
      sign_out @user

      get :index
      response.should redirect_to new_user_session_path 
    end

    it "assigns all tasks as @tasks as user" do
      get :index
      assigns(:tasks).should eq([task])
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      get :show, {:id => task.to_param}
      assigns(:task).should eq(task)
      response.should be_success
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new
      assigns(:task).should be_a_new(Task)
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      get :edit, {:id => task.to_param}
      assigns(:task).should eq(task)
      response.should be_success
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, {:task => task_attributes}
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {:task => task_attributes}
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the created task" do
        post :create, {:task => task_attributes}
        response.should redirect_to(Task.last)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested task" do
        Task.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => task.to_param, :task => { "title" => "MyString" }}
      end

      it "assigns the requested task as @task" do
        put :update, {:id => task.to_param, :task => task_attributes}
        assigns(:task).should eq(task)
      end

      it "redirects to the task" do
        put :update, {:id => task.to_param, :task => task_attributes}
        response.should redirect_to :back
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task
      expect {
        delete :destroy, {:id => task.to_param}
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, {:id => task.to_param}
      response.should redirect_to(tasks_url)
    end
  end

end
