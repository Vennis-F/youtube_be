require 'rails_helper'

RSpec.describe V1::VideosApi, type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)[0]}" } }

  describe 'GET /api/v1/videos' do
    let!(:videos) { 
      [
        double('Video', title: 'Video 1', url: 'https://youtube.com/1'),
        double('Video', title: 'Video 2', url: 'https://youtube.com/2'),
        double('Video', title: 'Video 3', url: 'https://youtube.com/3')
      ]
    }
  
    before do
      # Stub: Giả lập Video.all trả về mảng video giả lập
      allow(Video).to receive(:all).and_return(videos)
    end
  
    it 'returns a list of videos' do
      get '/api/v1/videos', headers: headers
  
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      puts body['data']
      expect(body['message']).to eq('Success')
      expect(body['data'].size).to eq(3)
      # Kiểm tra cấu trúc dữ liệu trả về
      expect(body['data'].first).to include('title', 'url')
    end
  end

end
