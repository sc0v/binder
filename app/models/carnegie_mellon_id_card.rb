# frozen_string_literal: true

class CarnegieMellonIDCard
  def self.initialize; end

  def self.get_andrewid_by_card_id(full_card_id)
    begin
      client = Savon.client(wsdl: 'https://csgapp.andrew.cmu.edu/csgoldwebservice/idtranslation.asmx?WSDL',
                            basic_auth: [ENV.fetch('CARDSERVICE_USERNAME', nil), ENV.fetch('CARDSERVICE_PASSWORD', nil)], convert_request_keys_to: :camelcase, log_level: :error, log: true)

      # Three track readers start with a % and then the card number
      # followed by lots of stuff.
      # Single track readers will just spit out the card number
      card_id = full_card_id[/\d{9}/]

      response = client.call(
        :get_card_holder_by_card_id,
        message: {
          CardID: card_id,
          CompleteRecordRequired: 'false'
        }
      )
      response_json = {
        first_name: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:first_name],
        last_name: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:last_name],
        andrewid: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:andrew_id],
        active: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:active],
        status: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:status],
        expiration: response.body[:get_card_holder_by_card_id_response][:get_card_holder_by_card_id_result][:expiration_date]
      }
    rescue Errno::ECONNREFUSED
      return nil
    end

    return if response_json.nil?

    response_json[:andrewid]
  end

  def self.get_andrewid_by_card_csn(full_card_csn)
    begin
      client = Savon.client(wsdl: 'https://csgapp.andrew.cmu.edu/csgoldwebservice/idtranslation.asmx?WSDL',
                            basic_auth: [ENV.fetch('CARDSERVICE_USERNAME', nil), ENV.fetch('CARDSERVICE_PASSWORD', nil)], convert_request_keys_to: :camelcase, log_level: :error, log: true)

      # Three track readers start with a % and then the card number
      # followed by lots of stuff.
      # Single track readers will just spit out the card number
      card_csn = full_card_csn[/[0-9a-fA-F]{8}/].upcase

      response = client.call(
        :get_card_holder_by_smar_card_csn,
        message: {
          SmartCardCSN: card_csn,
          CompleteRecordRequired: 'false'
        }
      )
      response_json = {
        first_name: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:first_name],
        last_name: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:last_name],
        andrewid: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:andrew_id],
        active: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:active],
        status: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:status],
        expiration: response.body[:get_card_holder_by_smar_card_csn_response][:get_card_holder_by_smar_card_csn_result][:expiration_date]
      }
    rescue Errno::ECONNREFUSED
      return nil
    end

    return if response_json.nil?

    response_json[:andrewid]
  end
end
