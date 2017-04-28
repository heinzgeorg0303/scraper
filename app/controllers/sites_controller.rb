class SitesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_site, only: [:edit, :update]

  def index
    @sites = Site.all
    @sites = @sites.search(params[:search][:value]) if (params[:search] || {})[:value].present?
    respond_to do |format|
      format.html {}
      format.json do
        @sites = @sites.offset(params[:start] || 0).limit(params[:length] || 10)
        (params[:order] || {}).each do |key, option|
          info = params[:columns][option[:column]]
          @sites = @sites.order(info[:data] => option[:dir])
        end
        render json: @sites
      end
    end
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new site_params
    @status = @site.save
  end

  def edit
  end

  def update
    @status = @site.update(site_params)
  end

  def fetch
    ScrapAlexa.new.run!
    redirect_to sites_path
  end

  def update_rank
    (params[:ranks] || {}).each do |id, rank|
      site = Site.find id
      site.rank = rank
      site.save(validate: false)
    end

    head 200
  end

  private

  def get_site
    @site = Site.find params[:id]
  end

  def site_params
    params.require(:site).permit(:rank, :name, :url, :description)
  end
end