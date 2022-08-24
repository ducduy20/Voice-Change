//
//  Privacy Policy.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 22/08/2022.
//

import SwiftUI

struct Privacy_Policy: View {
    
    var text =
            """
            These terms and conditions (“Agreement”) set forth the general terms and conditions of your use of the “Vocie Change” mobile application (“Mobile Application” or “Service”) and any of its related products and services (collectively, “Services”). This Agreement is legally binding between you (“User”, “you” or “your”) and this Mobile Application developer (“Operator”, “we”, “us” or “our”). If you are entering into this agreement on behalf of a business or other legal entity, you represent that you have the authority to bind such entity to this agreement, in which case the terms “User”, “you” or “your” shall refer to such entity. If you do not have such authority, or if you do not agree with the terms of this agreement, you must not accept this agreement and may not access and use the Mobile Application and Services. By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Agreement. You acknowledge that this Agreement is a contract between you and the Operator, even though it is electronic and is not physically signed by you, and it governs your use of the Mobile Application and Services.

            Age requirement

            You must be at least 13 years of age to use the Mobile Application and Services. By using the Mobile Application and Services and by agreeing to this Agreement you warrant and represent that you are at least 13 years of age.

            User content

            We do not own any data, information or material (collectively, “Content”) that you submit in the Mobile Application in the course of using the Service. You shall have sole responsibility for the accuracy, quality, integrity, legality, reliability, appropriateness, and intellectual property ownership or right to use of all submitted Content. We may monitor and review the Content in the Mobile Application submitted or created using our Services by you. You grant us permission to access, copy, distribute, store, transmit, reformat, display and perform the Content of your user account solely as required for the purpose of providing the Services to you. Without limiting any of those representations or warranties, we have the right, though not the obligation, to, in our own sole discretion, refuse or remove any Content that, in our reasonable opinion, violates any of our policies or is in any way harmful or objectionable. You also grant us the license to use, reproduce, adapt, modify, publish or distribute the Content created by you or stored in your user account for commercial, marketing or any similar purpose.

            Adult content

            Please be aware that there may be certain adult or mature content available in the Mobile Application. Where there is mature or adult content, individuals who are less than 18 years of age or are not permitted to access such content under the laws of any applicable jurisdiction may not access such content. If we learn that anyone under the age of 18 seeks to conduct a transaction through the Services, we will require verified parental consent, in accordance with the Children’s Online Privacy Protection Act of 1998 (“COPPA”). Certain areas of the Mobile Application and Services may not be available to children under 18 under any circumstances.

            Backups

            We perform regular backups of the Content, however, these backups are for our own administrative purposes only and are in no way guaranteed. You are responsible for maintaining your own backups of your data. We do not provide any sort of compensation for lost or incomplete data in the event that backups do not function properly. We will do our best to ensure complete and accurate backups, but assume no responsibility for this duty.

            Links to other resources

            Although the Mobile Application and Services may link to other resources (such as websites, mobile applications, etc.), we are not, directly or indirectly, implying any approval, association, sponsorship, endorsement, or affiliation with any linked resource, unless specifically stated herein. Some of the links in the Mobile Application may be “affiliate links”. This means if you click on the link and purchase an item, the Operator will receive an affiliate commission. We are not responsible for examining or evaluating, and we do not warrant the offerings of, any businesses or individuals or the content of their resources. We do not assume any responsibility or liability for the actions, products, services, and content of any other third parties. You should carefully review the legal statements and other conditions of use of any resource which you access through a link in the Mobile Application. Your linking to any other off-site resources is at your own risk.

            Intellectual property rights

            “Intellectual Property Rights” means all present and future rights conferred by statute, common law or equity in or in relation to any copyright and related rights, trademarks, designs, patents, inventions, goodwill and the right to sue for passing off, rights to inventions, rights to use, and all other intellectual property rights, in each case whether registered or unregistered and including all applications and rights to apply for and be granted, rights to claim priority from, such rights and all similar or equivalent rights or forms of protection and any other results of intellectual activity which subsist or will subsist now or in the future in any part of the world. This Agreement does not transfer to you any intellectual property owned by the Operator or third parties, and all rights, titles, and interests in and to such property will remain (as between the parties) solely with the Operator. All trademarks, service marks, graphics and logos used in connection with the Mobile Application and Services, are trademarks or registered trademarks of the Operator or its licensors. Other trademarks, service marks, graphics and logos used in connection with the Mobile Application and Services may be the trademarks of other third parties. Your use of the Mobile Application and Services grants you no right or license to reproduce or otherwise use any of the Operator or third party trademarks.

            Limitation of liability

            To the fullest extent permitted by applicable law, in no event will the Operator, its affiliates, directors, officers, employees, agents, suppliers or licensors be liable to any person for any indirect, incidental, special, punitive, cover or consequential damages (including, without limitation, damages for lost profits, revenue, sales, goodwill, use of content, impact on business, business interruption, loss of anticipated savings, loss of business opportunity) however caused, under any theory of liability, including, without limitation, contract, tort, warranty, breach of statutory duty, negligence or otherwise, even if the liable party has been advised as to the possibility of such damages or could have foreseen such damages. To the maximum extent permitted by applicable law, the aggregate liability of the Operator and its affiliates, officers, employees, agents, suppliers and licensors relating to the services will be limited to an amount no greater than one dollar or any amounts actually paid in cash by you to the Operator for the prior one month period prior to the first event or occurrence giving rise to such liability. The limitations and exclusions also apply if this remedy does not fully compensate you for any losses or fails of its essential purpose.

            Dispute resolution

            The formation, interpretation, and performance of this Agreement and any disputes arising out of it shall be governed by the substantive and procedural laws of Vietnam without regard to its rules on conflicts or choice of law and, to the extent applicable, the laws of Vietnam. The exclusive jurisdiction and venue for actions related to the subject matter hereof shall be the courts located in Vietnam, and you hereby submit to the personal jurisdiction of such courts. You hereby waive any right to a jury trial in any proceeding arising out of or related to this Agreement. The United Nations Convention on Contracts for the International Sale of Goods does not apply to this Agreement.

            Changes and amendments

            We reserve the right to modify this Agreement or its terms related to the Mobile Application and Services at any time at our discretion. When we do, we will revise the updated date at the bottom of this page. We may also provide notice to you in other ways at our discretion, such as through the contact information you have provided.

            An updated version of this Agreement will be effective immediately upon the posting of the revised Agreement unless otherwise specified. Your continued use of the Mobile Application and Services after the effective date of the revised Agreement (or such other act specified at that time) will constitute your consent to those changes.

            Acceptance of these terms

            You acknowledge that you have read this Agreement and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Agreement. If you do not agree to abide by the terms of this Agreement, you are not authorized to access or use the Mobile Application and Services. This terms and conditions policy was created with the help of WebsitePolicies.com

            Contacting us

            If you have any questions, concerns, or complaints regarding this Agreement, we encourage you to contact us using the details below:

            tranduy10062k@gmail.com

            This document was last updated on August 22, 2022
"""
    @Environment(\.presentationMode) var presentationMode
    var resultCallBack: ((Bool) -> ())
    var body: some View{
        VStack{
            Spacer()
            ScrollView{
                Text(text)
                    .font(.body)
                    .foregroundColor(.black)
            }
            Divider()
            HStack{
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Don't Allow")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
                Divider()
                    .frame(width: 1, height: 30)
                Spacer()
                Button {
                    resultCallBack(false)
                } label: {
                    Text("Allow")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
                
            }
        }
        .padding(.vertical,16)
        .frame(width:  360, height: UIScreen.height - 120, alignment: .leading)
        .background(Color(.white).opacity(0.9))
        .cornerRadius(20)
    }
}

struct Privacy_Policy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy_Policy{_ in }
    }
}
