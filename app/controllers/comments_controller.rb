class CommentsController < ApplicationController
    before_filter :authenticate_user!

    ## GET /scan/comments
    ## GET /scan/comments.json
    #def index
    #    @comments = Comment.all
    #
    #    respond_to do |format|
    #        format.html # index.html.erb
    #        format.json { render json: @comments }
    #    end
    #end
    #
    ## GET /scan/comments/1
    ## GET /scan/comments/1.json
    #def show
    #    @comment = Comment.find(params[:id])
    #
    #    respond_to do |format|
    #        format.html # show.html.erb
    #        format.json { render json: @comment }
    #    end
    #end
    #
    ## GET /scan/comments/new
    ## GET /scan/comments/new.json
    #def new
    #    @comment = Comment.new
    #
    #    respond_to do |format|
    #        format.html # new.html.erb
    #        format.json { render json: @comment }
    #    end
    #end
    #
    ## GET /scan/comments/1/edit
    #def edit
    #    @comment = Comment.find(params[:id])
    #end

    # POST /scan/comments
    # POST /scan/comments.json
    def create
        begin
            current_user.scans.find( params[:comment][:scan_id] )
        rescue ActiveRecord::RecordNotFound
            fail 'You do not have permission to access this scan.'
        end

        @comment      = Comment.new(params[:comment])
        @comment.user = current_user

        respond_to do |format|
            if @comment.save
                format.html { redirect_to :back, notice: 'Comment was successfully created.' }
                format.json { render json: @comment, status: :created, location: @comment }
            else
                format.html { render action: "new" }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /scan/comments/1
    # PUT /scan/comments/1.json
    def update
        begin
            current_user.scans.find( params[:comment][:scan_id] )
        rescue ActiveRecord::RecordNotFound
            fail 'You do not have permission to access this scan.'
        end

        @comment = Comment.find(params[:id])

        respond_to do |format|
            if @comment.update_attributes(params[:comment])
                format.html { redirect_to :back, notice: 'Comment was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /scan/comments/1
    # DELETE /scan/comments/1.json
    def destroy
        begin
            current_user.scans.find( params[:comment][:scan_id] )
        rescue ActiveRecord::RecordNotFound
            fail 'You do not have permission to access this scan.'
        end

        @comment = Comment.find(params[:id])
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to comments_url }
            format.json { head :no_content }
        end
    end
end