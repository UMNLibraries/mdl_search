module MDL
  class RightsConfig
    attr_reader :url
    def initialize(url: '')
      @url = url
    end
    def mappings
      [
        {
          url: 'http://rightsstatements.org/vocab/NoC-US/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/NoC-US.dark-white-interior.png',
          name: 'NO COPYRIGHT - UNITED STATES',
          text: 'The organization that has made the Item available believes that the Item is in the Public Domain under the laws of the United States, but a determination was not made as to its copyright status under the copyright laws of other countries. The Item may not be in the Public Domain under the laws of other countries. Please refer to the organization that has made the Item available for more information.'
        },
        {
          url: 'http://rightsstatements.org/vocab/InC/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/InC.dark-white-interior.png',
          name: 'IN COPYRIGHT',
          text: 'This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. For other uses you need to obtain permission from the rights-holder(s).'
        },
        {
          url: 'http://rightsstatements.org/vocab/NKC/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/NKC.dark-white-interior.png',
          name: 'NO KNOWN COPYRIGHT',
          text: 'The organization that has made the Item available reasonably believes that the Item is not restricted by copyright or related rights, but a conclusive determination could not be made. Please refer to the organization that has made the Item available for more information. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use.'
        },
        {
          url: 'http://rightsstatements.org/vocab/UND/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/UND.dark-white-interior.png',
          name: 'COPYRIGHT UNDETERMINED',
          text: 'The copyright and related rights status of this Item has been reviewed by the organization that has made the Item available, but the organization was unable to make a conclusive determination as to the copyright status of the Item. Please refer to the organization that has made the Item available for more information. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use.'
        },
        {
          url: 'http://rightsstatements.org/vocab/CNE/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/CNE.dark-white-interior.png',
          name: 'COPYRIGHT NOT EVALUATED',
          text: 'The copyright and related rights status of this Item has not been evaluated. Please refer to the organization that has made the Item available for more information. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use.'
        },
        {
          url: 'http://rightsstatements.org/vocab/InC-RUU/1.0/',
          image_url: 'http://rightsstatements.org/files/buttons/InC-RUU.dark-white-interior.png',
          name: 'IN COPYRIGHT - RIGHTS-HOLDER(S) UNLOCATABLE OR UNIDENTIFIABLE',
          text: 'This Item is protected by copyright and/or related rights. However, for this Item, either (a) no rights-holder(s) have been identified or (b) one or more rights-holder(s) have been identified but none have been located. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use.'
        },
        {
          url: 'https://creativecommons.org/licenses/by/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by.png',
          name: 'Attribution 4.0 International (CC BY 4.0)',
          text: ''
        },
        {
          url: 'https://creativecommons.org/licenses/by-nc-nd/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nc-nd.png',
          name: 'Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)',
          text: ''
        },
        {
          url: 'https://creativecommons.org/licenses/by-sa/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-sa.png',
          name: 'Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)',
          text: ''
        },
        {
          url: 'https://creativecommons.org/licenses/by-nd/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nd.png',
          name: 'Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0)',
          text: ''
        },
        {
          url: 'https://creativecommons.org/licenses/by-nc/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nc.png',
          name: 'Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)',
          text: ''
        },
        {
          url: 'https://creativecommons.org/licenses/by-nc-sa/4.0/',
          image_url: 'https://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nc-sa.png',
          name: 'Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)',
          text: ''
        }
      ]
    end

    def exists?
      mappings.any? { |mapping| mapping[:url] == url }
    end

    def mapping
      mappings.select { |mapping| mapping[:url] == url }.first
    end
 end
end