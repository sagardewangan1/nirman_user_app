import 'package:qixer/model/area_dropdown_model.dart';
import 'package:qixer/model/dropdown_models/area_dropdown_model.dart';

/// my_services : [{"id":55,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"dsadas","slug":"dsadas","description":"<p>dsadasdasda</p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; list-style-type: none; color: rgb(135, 138, 149); font-family: Manrope, sans-serif; font-size: 16px;\"><li class=\"page_item page-item-15948 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/currency-settings/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Currency Settings</a></li><li class=\"page_item page-item-15947 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paypal/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paypal</a></li><li class=\"page_item page-item-15946 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paytm/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paytm</a></li><li class=\"page_item page-item-15945 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paystack/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paystack</a></li><li class=\"page_item page-item-15944 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/stripe/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Stripe</a></li><li class=\"page_item page-item-15943 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/flutterwave/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Flutterwave</a></li><li class=\"page_item page-item-15942 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/mollie/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Mollie</a></li><li class=\"page_item page-item-15941 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/razorpay/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Razorpay</a></li><li class=\"page_item page-item-15940 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/manual-payment/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Manual Payment</a></li><li class=\"page_item page-item-15939 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/midtrans-how-to-get-merchant-id-and-client-key-and-server-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">midtrans – how to get Merchant id and Client key and server key ?</a></li><li class=\"page_item page-item-15938 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/payfast-how-to-find-my-merchant-id-and-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Payfast – How To Find my Merchant ID and Key?</a></li><li class=\"page_item page-item-15937 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/cashfree-where-to-get-app-id-and-secret-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Cashfree – Where to get App Id and Secret Key?</a></li><li class=\"page_item page-item-15936 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/instamojo-how-do-i-get-my-client-id-and-client-secret/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Instamojo – How do I get my Client ID and Client Secret?</a></li><li class=\"page_item page-item-15935 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/mercadopago/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Mercadopago</a></li><li class=\"page_item page-item-15934 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/payumoney-how-to-get-payumoney-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">PayUMoney – How to get PayUMoney Api Credentials</a></li><li class=\"page_item page-item-15933 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-get-square-payment-gateway-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How to get Square Payment gateway Api Credentials</a></li><li class=\"page_item page-item-15932 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/cinetpay-integratoin-how-to-get-api-key-and-site-id/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">CinetPay Integratoin- How to get Api Key and Site Id</a></li><li class=\"page_item page-item-15931 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-get-paytabs-payment-gateway-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How to get Paytabs payment gateway api credentials</a></li><li class=\"page_item page-item-15930 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-setup-api-for-billplz-payment-gateway/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How To Setup Api For BillPlz Payment Gateway</a></li><li class=\"page_item page-item-15929 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/zitopay-payment-gateway-setup/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Zitopay – Payment gateway setup</a></li><li class=\"page_item page-item-16712 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-configure-paddle-recurring-payment-gateway-paid-plugin/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">how to configure paddle recurring payment gateway ( Paid Plugin )</a></li></ul>","image":{"image_id":734,"path":"f61690578864.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/f61690578864.jpg","img_alt":null},"seller_id":2,"service_city_id":50,"service_area_id":"110","status":0,"is_service_all_cities":0,"experience":null,"price":200,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":30,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"test 2/20","slug":"test-220","description":"<p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"[\"112\",\"110\"]","status":0,"is_service_all_cities":0,"experience":null,"price":50000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":29,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"dsadasdad","slug":"dsadasdad","description":"<p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"[\"111\"]","status":0,"is_service_all_cities":0,"experience":null,"price":5000222,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":28,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"after zero","slug":"after-zero","description":"dsadasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss<span style=\"color: rgb(66, 77, 97); font-family: Helvetica, Arial; text-align: var(--bs-body-text-align); display: inline !important;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</span><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":0,"is_service_all_cities":0,"experience":null,"price":500,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":27,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"dsad","slug":"dsad","description":"<p>dasda<span style=\"color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px; text-align: var(--bs-body-text-align); display: inline !important;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</span></p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":0,"is_service_all_cities":0,"experience":null,"price":5000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":26,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"sdadasdad","slug":"sdadasdad","description":"<p>dadasdsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa<span style=\"color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px; text-align: var(--bs-body-text-align); display: inline !important;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</span></p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":0,"is_service_all_cities":0,"experience":null,"price":5000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":25,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"after gold 0 subscription ","slug":"after-gold-0-subscription","description":"<p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character Counter is a 100% free online character count calculator that's simple to use. Sometimes users prefer simplicity over all of the detailed writing information Word Counter provides, and this is exactly what this tool offers. It displays character count and word count which is often the only information a person needs to know about their writing. Best of all, you receive the needed information at a lightning fast speed.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">To find out the word and character count of your writing, simply copy and paste text into the tool or write directly into the text area. Once done, the free online tool will display both counts for the text that's been inserted. This can be useful in many instances, but it can be especially helpful when you are writing for something that has a character minimum or limit.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">Character and word limits are quite common these days on the Internet. The one that most people are likely aware of is the 140 character limit for tweets on Twitter, but character limits aren't restricted to Twitter. There are limits for text messages (SMS), Yelp reviews, Facebook posts, Pinterest pins, Reddit titles and comments, eBay titles and descriptions as well as many others. Knowing these limits, as well as being able to see as you approach them, will enable you to better express yourself within the imposed limits.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">For students, there are usually limits or minimums for homework assignments. The same is often true for college applications. Abiding by these can have a major impact on how this writing is graded and reviewed, and it shows whether or not you're able to follow basic directions. Character counter can make sure you don't accidentally go over limits or fail to meet minimums that can be detrimental to these assignments.</p><p style=\"margin-right: 0px; margin-bottom: 10px; margin-left: 0px; color: rgb(66, 77, 97); font-family: Helvetica, Arial; font-size: 14px;\">This information can also be quite helpful for writers. Knowing the number of words and characters can help writers better understand the length of their writing, and work to display the pages of their writing in a specific way. For those who write for magazines and newspapers where there is limited space, knowing these counts can help the writer get the most information into that limited space.</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":0,"is_service_all_cities":0,"experience":null,"price":50012,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":24,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"hhdhsadhas","slug":"hhdhsadhas","description":"<p>dsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadddddddddddddddddddddddddddddd</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":1,"is_service_all_cities":0,"experience":null,"price":50000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":23,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"before subscription","slug":"before-subscription","description":"<p>dasdassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh</p>","image":{"image_id":735,"path":"f51690578864.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/f51690578864.jpg","img_alt":null},"seller_id":2,"service_city_id":50,"service_area_id":"110","status":1,"is_service_all_cities":0,"experience":null,"price":50000000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":22,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"test 2121","slug":"test-2121","description":"<p>hhdhahdhasdhhasddasddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd</p>","image":{"image_id":731,"path":"f11690578859.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/f11690578859.jpg","img_alt":null},"seller_id":2,"service_city_id":50,"service_area_id":"[\"112\"]","status":1,"is_service_all_cities":0,"experience":null,"price":5000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":20,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"test2","slug":"test2","description":"description","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"[\"110\"]","status":1,"is_service_all_cities":0,"experience":"5","price":0,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":21,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"test2","slug":"test2-1","description":"description","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"[\"110\"]","status":1,"is_service_all_cities":0,"experience":"5","price":0,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":15,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"ttele","slug":"ttele","description":"<p>dasdassssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss</p>","image":{"image_id":744,"path":"message-21690579648.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/message-21690579648.jpg","img_alt":null},"seller_id":2,"service_city_id":50,"service_area_id":"[\"111\",\"112\"]","status":0,"is_service_all_cities":1,"experience":null,"price":1220,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":9,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"Transformative Interior Design Services","slug":"transformative-interior-design-services","description":"<p style=\"text-align: center;\"><b>We believe in creating spaces that inspire and reflect your unique style. Our passionate team of interior designers collaborates closely with you to transform your vision into reality, blending aesthetics with functionality.</b><br><br><img src=\"https://surya.pomonallp.com/assets/uploads/media-uploader/dribbble21738225847.gif\" style=\"width: 800px;\"></p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\"><b>What We Offer:\r\n</b></p><p style=\"text-align: center;\">\r\n</p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\">Personalized Designs: We take the time to understand your lifestyle and preferences, crafting custom solutions tailored to your needs.\r\n</p><p style=\"text-align: center;\">Space Planning: Maximize your space’s potential with strategic layouts that enhance flow and comfort.\r\n</p><p style=\"text-align: center;\">Color &amp; Material Consultation: Our experts guide you in choosing the perfect color schemes and materials that bring your space to life.\r\n</p><p style=\"text-align: center;\">Sustainable Design: We prioritize eco-friendly materials and practices, ensuring your space is both beautiful and sustainable.\r\n</p><p style=\"text-align: center;\">Full Project Management: From concept to completion, we manage every detail, ensuring a stress-free experience for our clients.\r\n</p><p style=\"text-align: center;\">Let us elevate your environment to new heights. Contact us today to start your interior design journey!\r\n</p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\">\r\n</p>","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":1,"is_service_all_cities":0,"experience":null,"price":10,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":8,"category_id":1,"subcategory_id":1,"child_category_id":null,"title":"We Design Web Pages","slug":"we-design-web-pages","description":"<p style=\"text-align: center; \"><b>we specialize in crafting unique, user-friendly websites tailored to your brand’s vision. Our expert team blends creativity with the latest technology to deliver stunning designs that not only captivate your audience but also drive conversions.\r\n</b></p><p><b>Key Features:\r\n</b></p><p>Responsive Design: Ensure your website looks great on all devices, from desktops to smartphones.\r\n</p><p>User Experience Focus: We prioritize seamless navigation and usability, enhancing user satisfaction.\r\n</p><p>SEO-Optimized: Our designs incorporate best SEO practices to improve your website's visibility on search engines.\r\n</p><p>Custom Solutions: We offer bespoke designs that reflect your brand's identity, ensuring a standout online presence.\r\n</p><p>Ongoing Support: Our commitment doesn’t end at launch; we provide continuous support and maintenance to keep your site running smoothly.\r\n</p><p>Transform your online presence with our tailored web design solutions. Contact us today for a consultation!</p><p>\r\n</p><p>\r\n</p>","image":{"image_id":926,"path":"images-11738416044.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/images-11738416044.jpg","img_alt":null},"seller_id":2,"service_city_id":50,"service_area_id":"111","status":1,"is_service_all_cities":0,"experience":null,"price":8000,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]},{"id":1,"category_id":1,"subcategory_id":null,"child_category_id":null,"title":"Premium Web Design Service","slug":"premium-web-design-service","description":"We offer top-notch web design services that will make your website stand out.","image":[],"seller_id":2,"service_city_id":50,"service_area_id":"110","status":1,"is_service_all_cities":1,"experience":null,"price":0,"reviews_count":0,"pending_order_count":0,"complete_order_count":0,"cancel_order_count":0,"reviews_for_mobile":[]}]

class MyServiceListDataModel {
  MyServiceListDataModel({
    List<MyServices>? myServices,
  }) {
    _myServices = myServices;
  }

  MyServiceListDataModel.fromJson(dynamic json) {
    if (json['my_services'] != null) {
      _myServices = [];
      json['my_services'].forEach((v) {
        _myServices?.add(MyServices.fromJson(v));
      });
    }
  }
  List<MyServices>? _myServices;
  MyServiceListDataModel copyWith({
    List<MyServices>? myServices,
  }) =>
      MyServiceListDataModel(
        myServices: myServices ?? _myServices,
      );
  List<MyServices>? get myServices => _myServices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_myServices != null) {
      map['my_services'] = _myServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 55
/// category_id : 1
/// subcategory_id : 1
/// child_category_id : null
/// title : "dsadas"
/// slug : "dsadas"
/// description : "<p>dsadasdasda</p><ul style=\"padding: 0px; margin-right: 0px; margin-bottom: 30px; margin-left: 0px; list-style-type: none; color: rgb(135, 138, 149); font-family: Manrope, sans-serif; font-size: 16px;\"><li class=\"page_item page-item-15948 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/currency-settings/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Currency Settings</a></li><li class=\"page_item page-item-15947 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paypal/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paypal</a></li><li class=\"page_item page-item-15946 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paytm/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paytm</a></li><li class=\"page_item page-item-15945 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/paystack/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Paystack</a></li><li class=\"page_item page-item-15944 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/stripe/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Stripe</a></li><li class=\"page_item page-item-15943 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/flutterwave/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Flutterwave</a></li><li class=\"page_item page-item-15942 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/mollie/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Mollie</a></li><li class=\"page_item page-item-15941 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/razorpay/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Razorpay</a></li><li class=\"page_item page-item-15940 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/manual-payment/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Manual Payment</a></li><li class=\"page_item page-item-15939 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/midtrans-how-to-get-merchant-id-and-client-key-and-server-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">midtrans – how to get Merchant id and Client key and server key ?</a></li><li class=\"page_item page-item-15938 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/payfast-how-to-find-my-merchant-id-and-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Payfast – How To Find my Merchant ID and Key?</a></li><li class=\"page_item page-item-15937 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/cashfree-where-to-get-app-id-and-secret-key/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Cashfree – Where to get App Id and Secret Key?</a></li><li class=\"page_item page-item-15936 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/instamojo-how-do-i-get-my-client-id-and-client-secret/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Instamojo – How do I get my Client ID and Client Secret?</a></li><li class=\"page_item page-item-15935 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/mercadopago/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Mercadopago</a></li><li class=\"page_item page-item-15934 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/payumoney-how-to-get-payumoney-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">PayUMoney – How to get PayUMoney Api Credentials</a></li><li class=\"page_item page-item-15933 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-get-square-payment-gateway-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How to get Square Payment gateway Api Credentials</a></li><li class=\"page_item page-item-15932 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/cinetpay-integratoin-how-to-get-api-key-and-site-id/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">CinetPay Integratoin- How to get Api Key and Site Id</a></li><li class=\"page_item page-item-15931 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-get-paytabs-payment-gateway-api-credentials/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How to get Paytabs payment gateway api credentials</a></li><li class=\"page_item page-item-15930 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-setup-api-for-billplz-payment-gateway/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">How To Setup Api For BillPlz Payment Gateway</a></li><li class=\"page_item page-item-15929 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/zitopay-payment-gateway-setup/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">Zitopay – Payment gateway setup</a></li><li class=\"page_item page-item-16712 wd-state-closed\" style=\"margin-top: 15px; transition: 0.3s;\"><a href=\"https://docs.xgenious.com/docs/nazmart-multi-tenancy-ecommerce-platform-saas/payment-gateway-settings/how-to-configure-paddle-recurring-payment-gateway-paid-plugin/\" style=\"text-transform: capitalize; padding: 7px 20px; margin: 10px 0px;\">how to configure paddle recurring payment gateway ( Paid Plugin )</a></li></ul>"
/// image : {"image_id":734,"path":"f61690578864.jpg","img_url":"https://sashaktnirmaan.com/assets/uploads/media-uploader/f61690578864.jpg","img_alt":null}
/// seller_id : 2
/// service_city_id : 50
/// service_area_id : "110"
/// status : 0
/// is_service_all_cities : 0
/// experience : null
/// price : 200
/// reviews_count : 0
/// pending_order_count : 0
/// complete_order_count : 0
/// cancel_order_count : 0
/// reviews_for_mobile : []

class MyServices {
  MyServices({
    dynamic id,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic childCategoryId,
    String? title,
    String? slug,
    String? description,
    Image? image,
    dynamic sellerId,
    dynamic serviceCityId,
    dynamic serviceAreaId,
    dynamic status,
    dynamic isServiceAllCities,
    dynamic experience,
    dynamic price,
    dynamic reviewsCount,
    dynamic pendingOrderCount,
    dynamic completeOrderCount,
    dynamic cancelOrderCount,
    List<dynamic>? reviewsForMobile,
    Category? category,
    Subcategory? subcategory,
    List<ServiceArea>? serviceArea,
    Seller? seller,
  }) {
    _id = id;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _childCategoryId = childCategoryId;
    _title = title;
    _slug = slug;
    _description = description;
    _image = image;
    _sellerId = sellerId;
    _serviceCityId = serviceCityId;
    _serviceAreaId = serviceAreaId;
    _status = status;
    _isServiceAllCities = isServiceAllCities;
    _experience = experience;
    _price = price;
    _reviewsCount = reviewsCount;
    _pendingOrderCount = pendingOrderCount;
    _completeOrderCount = completeOrderCount;
    _cancelOrderCount = cancelOrderCount;
    _reviewsForMobile = reviewsForMobile;
    _category = category;
    _subcategory = subcategory;
    _serviceArea = serviceArea;
    _seller = seller;
  }

  MyServices.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _childCategoryId = json['child_category_id'];
    _title = json['title'];
    _slug = json['slug'];
    _description = json['description'];
    // ✅ Handle "image" being either an object `{}` or an empty list `[]`
    if (json['image'] is Map<String, dynamic>) {
      _image = Image.fromJson(json['image']); // ✅ Parse normally if it's a Map
    } else {
      _image = null; // ✅ If it's a list (`[]`), set `_image` to null
    }
    _sellerId = json['seller_id'];
    _serviceCityId = json['service_city_id'];
    _serviceAreaId = json['service_area_id'];
    _status = json['status'];
    _isServiceAllCities = json['is_service_all_cities'];
    _experience = json['experience'];
    _price = json['price'];
    _reviewsCount = json['reviews_count'];
    _pendingOrderCount = json['pending_order_count'];
    _completeOrderCount = json['complete_order_count'];
    _cancelOrderCount = json['cancel_order_count'];
    if (json['reviews_for_mobile'] != null) {
      _reviewsForMobile = [];
      // json['reviews_for_mobile'].forEach((v) {
      //   _reviewsForMobile?.add();
      // });
    }
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _subcategory = json['subcategory'] != null
        ? Subcategory.fromJson(json['subcategory'])
        : null;
    _serviceArea = json['service_areas'] != null &&
            (json['service_areas'] is List && json['service_areas'].isNotEmpty)
        ? (json['service_areas'] as List)
            .map((e) => ServiceArea.fromJson(e as Map<String, dynamic>))
            .toList()
        : [];
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }
  dynamic _id;
  dynamic _categoryId;
  dynamic _subcategoryId;
  dynamic _childCategoryId;
  String? _title;
  String? _slug;
  String? _description;
  Image? _image;
  dynamic _sellerId;
  dynamic _serviceCityId;
  dynamic _serviceAreaId;
  dynamic _status;
  dynamic _isServiceAllCities;
  dynamic _experience;
  dynamic _price;
  dynamic _reviewsCount;
  dynamic _pendingOrderCount;
  dynamic _completeOrderCount;
  dynamic _cancelOrderCount;
  List<dynamic>? _reviewsForMobile;
  Category? _category;
  Subcategory? _subcategory;
  List<ServiceArea>? _serviceArea;
  Seller? _seller;
  MyServices copyWith({
    dynamic id,
    dynamic categoryId,
    dynamic subcategoryId,
    dynamic childCategoryId,
    String? title,
    String? slug,
    String? description,
    Image? image,
    dynamic sellerId,
    dynamic serviceCityId,
    dynamic serviceAreaId,
    dynamic status,
    dynamic isServiceAllCities,
    dynamic experience,
    dynamic price,
    dynamic reviewsCount,
    dynamic pendingOrderCount,
    dynamic completeOrderCount,
    dynamic cancelOrderCount,
    List<dynamic>? reviewsForMobile,
    Category? category,
    Subcategory? subcategory,
    List<ServiceArea>? serviceArea,
    Seller? seller,
  }) =>
      MyServices(
          id: id ?? _id,
          categoryId: categoryId ?? _categoryId,
          subcategoryId: subcategoryId ?? _subcategoryId,
          childCategoryId: childCategoryId ?? _childCategoryId,
          title: title ?? _title,
          slug: slug ?? _slug,
          description: description ?? _description,
          image: image ?? _image,
          sellerId: sellerId ?? _sellerId,
          serviceCityId: serviceCityId ?? _serviceCityId,
          serviceAreaId: serviceAreaId ?? _serviceAreaId,
          status: status ?? _status,
          isServiceAllCities: isServiceAllCities ?? _isServiceAllCities,
          experience: experience ?? _experience,
          price: price ?? _price,
          reviewsCount: reviewsCount ?? _reviewsCount,
          pendingOrderCount: pendingOrderCount ?? _pendingOrderCount,
          completeOrderCount: completeOrderCount ?? _completeOrderCount,
          cancelOrderCount: cancelOrderCount ?? _cancelOrderCount,
          reviewsForMobile: reviewsForMobile ?? _reviewsForMobile,
          category: category ?? _category,
          subcategory: subcategory ?? _subcategory,
          serviceArea: serviceArea ?? _serviceArea,
          seller: seller ?? _seller);
  dynamic get id => _id;
  dynamic get categoryId => _categoryId;
  dynamic get subcategoryId => _subcategoryId;
  dynamic get childCategoryId => _childCategoryId;
  String? get title => _title;
  String? get slug => _slug;
  String? get description => _description;
  Image? get image => _image;
  dynamic get sellerId => _sellerId;
  dynamic get serviceCityId => _serviceCityId;
  dynamic get serviceAreaId => _serviceAreaId;
  dynamic get status => _status;
  dynamic get isServiceAllCities => _isServiceAllCities;
  dynamic get experience => _experience;
  dynamic get price => _price;
  dynamic get reviewsCount => _reviewsCount;
  dynamic get pendingOrderCount => _pendingOrderCount;
  dynamic get completeOrderCount => _completeOrderCount;
  dynamic get cancelOrderCount => _cancelOrderCount;
  List<dynamic>? get reviewsForMobile => _reviewsForMobile;
  Category? get category => _category;
  Subcategory? get subcategory => _subcategory;
  List<ServiceArea>? get serviceArea => _serviceArea;
  Seller? get seller => _seller;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['child_category_id'] = _childCategoryId;
    map['title'] = _title;
    map['slug'] = _slug;
    map['description'] = _description;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['seller_id'] = _sellerId;
    map['service_city_id'] = _serviceCityId;
    map['service_area_id'] = _serviceAreaId;
    map['status'] = _status;
    map['is_service_all_cities'] = _isServiceAllCities;
    map['experience'] = _experience;
    map['price'] = _price;
    map['reviews_count'] = _reviewsCount;
    map['pending_order_count'] = _pendingOrderCount;
    map['complete_order_count'] = _completeOrderCount;
    map['cancel_order_count'] = _cancelOrderCount;
    if (_reviewsForMobile != null) {
      map['reviews_for_mobile'] =
          _reviewsForMobile?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_subcategory != null) {
      map['subcategory'] = _subcategory?.toJson();
    }
    if (_serviceArea != null && _serviceArea!.isNotEmpty) {
      map['service_areas'] = _serviceArea!.map((e) => e.toJson()).toList();
    }
    if (_seller != null) {
      map['seller'] = _seller;
    }
    return map;
  }
}

/// image_id : 734
/// path : "f61690578864.jpg"
/// img_url : "https://sashaktnirmaan.com/assets/uploads/media-uploader/f61690578864.jpg"
/// img_alt : null

class Image {
  Image({
    int? imageId,
    String? path,
    String? imgUrl,
    dynamic imgAlt,
  }) {
    _imageId = imageId;
    _path = path;
    _imgUrl = imgUrl;
    _imgAlt = imgAlt;
  }

  Image.fromJson(Map<String, dynamic> json) {
    _imageId = json['image_id'];
    _path = json['path'];
    _imgUrl = json['img_url'];
    _imgAlt = json['img_alt'];
  }
  int? _imageId;
  String? _path;
  String? _imgUrl;
  dynamic _imgAlt;
  Image copyWith({
    dynamic imageId,
    String? path,
    String? imgUrl,
    dynamic imgAlt,
  }) =>
      Image(
        imageId: imageId ?? _imageId,
        path: path ?? _path,
        imgUrl: imgUrl ?? _imgUrl,
        imgAlt: imgAlt ?? _imgAlt,
      );
  int? get imageId => _imageId;
  String? get path => _path;
  String? get imgUrl => _imgUrl;
  dynamic get imgAlt => _imgAlt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_id'] = _imageId;
    map['path'] = _path;
    map['img_url'] = _imgUrl;
    map['img_alt'] = _imgAlt;
    return map;
  }
}

/// id : 1
/// category_id : 1
/// name : "House Plan Design"
/// description : "<p>(Design Concept / 3D House Plan / Elevation / Walkthrough)\r\n</p><p><br></p>"
/// slug : "house-plan-design-"
/// image : "933"
/// status : 1
/// created_at : "2025-01-30T08:16:40.000000Z"
/// updated_at : "2025-02-06T09:03:35.000000Z"

class Subcategory {
  Subcategory({
    num? id,
    num? categoryId,
    String? name,
    String? description,
    String? slug,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _categoryId = categoryId;
    _name = name;
    _description = description;
    _slug = slug;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Subcategory.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _description = json['description'];
    _slug = json['slug'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _categoryId;
  String? _name;
  String? _description;
  String? _slug;
  String? _image;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  Subcategory copyWith({
    num? id,
    num? categoryId,
    String? name,
    String? description,
    String? slug,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      Subcategory(
        id: id ?? _id,
        categoryId: categoryId ?? _categoryId,
        name: name ?? _name,
        description: description ?? _description,
        slug: slug ?? _slug,
        image: image ?? _image,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get categoryId => _categoryId;
  String? get name => _name;
  String? get description => _description;
  String? get slug => _slug;
  String? get image => _image;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['description'] = _description;
    map['slug'] = _slug;
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// id : 1
/// name : "Construction and Development Solutions (Civil Work)"
/// description : null
/// slug : "construction-and-development-solutions--civil-work-"
/// icon : "fas fa-exclamation-triangle"
/// image : "928"
/// status : 1
/// mobile_icon : "928"
/// created_at : "2025-01-30T08:02:07.000000Z"
/// updated_at : "2025-02-05T12:32:43.000000Z"

class Category {
  Category({
    num? id,
    String? name,
    dynamic description,
    String? slug,
    String? icon,
    String? image,
    num? status,
    String? mobileIcon,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _slug = slug;
    _icon = icon;
    _image = image;
    _status = status;
    _mobileIcon = mobileIcon;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _slug = json['slug'];
    _icon = json['icon'];
    _image = json['image'];
    _status = json['status'];
    _mobileIcon = json['mobile_icon'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  dynamic _description;
  String? _slug;
  String? _icon;
  String? _image;
  num? _status;
  String? _mobileIcon;
  String? _createdAt;
  String? _updatedAt;
  Category copyWith({
    num? id,
    String? name,
    dynamic description,
    String? slug,
    String? icon,
    String? image,
    num? status,
    String? mobileIcon,
    String? createdAt,
    String? updatedAt,
  }) =>
      Category(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        slug: slug ?? _slug,
        icon: icon ?? _icon,
        image: image ?? _image,
        status: status ?? _status,
        mobileIcon: mobileIcon ?? _mobileIcon,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  dynamic get description => _description;
  String? get slug => _slug;
  String? get icon => _icon;
  String? get image => _image;
  num? get status => _status;
  String? get mobileIcon => _mobileIcon;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['slug'] = _slug;
    map['icon'] = _icon;
    map['image'] = _image;
    map['status'] = _status;
    map['mobile_icon'] = _mobileIcon;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class ServiceArea {
  int? id;
  String? serviceArea;
  int? serviceCityId;
  int? countryId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceArea({
    this.id,
    this.serviceArea,
    this.serviceCityId,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceArea.fromJson(Map<String, dynamic> json) {
    return ServiceArea(
      id: json['id'] as int?,
      serviceArea: json['service_area'] as String?,
      serviceCityId: json['service_city_id'] as int?,
      countryId: json['country_id'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_area': serviceArea,
      'service_city_id': serviceCityId,
      'country_id': countryId,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Seller {
  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  String? businessName;
  String? businessGstNumber;
  String? businessPhoneNumber;
  String? businessEmail;
  String? businessFullAddress;
  String? businessDescription;
  List<String>? workingCategories;
  String? otpCode;
  int? otpVerified;
  String? image;
  String? profileBackground;
  String? serviceCity;
  List<String>? serviceArea;
  int? userType;
  int? sellerType;
  int? isNew;
  int? userStatus;
  int? termsCondition;
  String? address;
  String? state;
  String? about;
  String? taxNumber;
  String? businessRegistration;
  String? postCode;
  int? countryId;
  dynamic emailVerified;
  dynamic emailVerifyToken;
  String? facebookId;
  String? appleId;
  String? googleId;
  String? countryCode;
  String? createdAt;
  String? updatedAt;
  String? passwordChangedAt;
  String? lastSeen;
  String? otpExpireAt;
  String? zoneId;
  String? latitude;
  String? longitude;
  String? sellerAddress;
  BusinessImage? businessImage;

  Seller({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.businessName,
    this.businessGstNumber,
    this.businessPhoneNumber,
    this.businessEmail,
    this.businessFullAddress,
    this.businessDescription,
    this.workingCategories,
    this.otpCode,
    this.otpVerified,
    this.image,
    this.profileBackground,
    this.serviceCity,
    this.serviceArea,
    this.userType,
    this.sellerType,
    this.isNew,
    this.userStatus,
    this.termsCondition,
    this.address,
    this.state,
    this.about,
    this.taxNumber,
    this.businessRegistration,
    this.postCode,
    this.countryId,
    this.emailVerified,
    this.emailVerifyToken,
    this.facebookId,
    this.appleId,
    this.googleId,
    this.countryCode,
    this.createdAt,
    this.updatedAt,
    this.passwordChangedAt,
    this.lastSeen,
    this.otpExpireAt,
    this.zoneId,
    this.latitude,
    this.longitude,
    this.sellerAddress,
    this.businessImage,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      businessName: json['businessName'],
      businessGstNumber: json['businessGstNumber'],
      businessPhoneNumber: json['businessPhoneNumber'],
      businessEmail: json['businessEmail'],
      businessFullAddress: json['businessFullAddress'],
      businessDescription: json['businessDescription'],
      workingCategories:
          (json['working_categories'] as String?)?.split(',') ?? [],
      otpCode: json['otp_code'],
      otpVerified: json['otp_verified'],
      image: json['image'],
      profileBackground: json['profile_background'],
      serviceCity: json['service_city'],
      serviceArea: (json['service_area'] as String?)?.split(',') ?? [],
      userType: json['user_type'],
      sellerType: json['seller_type'],
      isNew: json['isNew'],
      userStatus: json['user_status'],
      termsCondition: json['terms_condition'],
      address: json['address'],
      state: json['state'],
      about: json['about'],
      taxNumber: json['tax_number'],
      businessRegistration: json['business_registration'],
      postCode: json['post_code'],
      countryId: json['country_id'],
      emailVerified: json['email_verified'] ?? 0,
      emailVerifyToken: json['email_verify_token'] ?? '',
      facebookId: json['facebook_id'],
      appleId: json['apple_id'],
      googleId: json['google_id'],
      countryCode: json['country_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      passwordChangedAt: json['password_changed_at'],
      lastSeen: json['last_seen'],
      otpExpireAt: json['otp_expire_at'],
      zoneId: json['zone_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      sellerAddress: json['seller_address'],
      businessImage: (json['businessImage'] is String &&
              json['businessImage'].isNotEmpty)
          ? BusinessImage(
              imgUrl: json[
                  'businessImage']) // Assuming BusinessImage has a 'url' field
          : (json['businessImage'] is Map<String, dynamic> &&
                  json['businessImage'].isNotEmpty)
              ? BusinessImage.fromJson(json['businessImage'])
              : null,
    );
  }

  /// ✅ **Method to convert object to JSON**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'businessName': businessName,
      'businessGstNumber': businessGstNumber,
      'businessPhoneNumber': businessPhoneNumber,
      'businessEmail': businessEmail,
      'businessFullAddress': businessFullAddress,
      'businessDescription': businessDescription,
      'working_categories':
          workingCategories?.join(','), // List ko string me convert kiya
      'otp_code': otpCode,
      'otp_verified': otpVerified,
      'image': image,
      'profile_background': profileBackground,
      'service_city': serviceCity,
      'service_area': serviceArea?.join(','), // List ko string me convert kiya
      'user_type': userType,
      'seller_type': sellerType,
      'isNew': isNew,
      'user_status': userStatus,
      'terms_condition': termsCondition,
      'address': address,
      'state': state,
      'about': about,
      'tax_number': taxNumber,
      'business_registration': businessRegistration,
      'post_code': postCode,
      'country_id': countryId,
      'email_verified': emailVerified,
      'email_verify_token': emailVerifyToken,
      'facebook_id': facebookId,
      'apple_id': appleId,
      'google_id': googleId,
      'country_code': countryCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'password_changed_at': passwordChangedAt,
      'last_seen': lastSeen,
      'otp_expire_at': otpExpireAt,
      'zone_id': zoneId,
      'latitude': latitude,
      'longitude': longitude,
      'seller_address': sellerAddress,
      'businessImage':
          businessImage?.toJson(), // Agar null nahi hai toh convert karega
    };
  }
}

class BusinessImage {
  int? imageId;
  String? path;
  String? imgUrl;
  String? imgAlt;

  BusinessImage({this.imageId, this.path, this.imgUrl, this.imgAlt});

  factory BusinessImage.fromJson(Map<String, dynamic> json) {
    return BusinessImage(
      imageId: json['image_id'],
      path: json['path'],
      imgUrl: json['img_url'],
      imgAlt: json['img_alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'path': path,
      'img_url': imgUrl,
      'img_alt': imgAlt,
    };
  }
}
