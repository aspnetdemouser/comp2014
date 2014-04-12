<%@ Page Title="" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="tracking.aspx.cs" Inherits="tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script type="text/javascript">
        function SetSelectedLinkTab() {

            // For attributes:
            //= is exactly equal
            //!= is not equal
            //^= is starts with
            //$= is ends with
            //*= is contains

            $('a[href*="tracking.aspx"]').parent().addClass("sel");
        }
        $(document).ready(function () {
            SetSelectedLinkTab();
        });
            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="gray_box calendar_gray_box">

		<div class="box_title">
			<h2>Calendar</h2>
			<div class="calendar">
				<div class="cal_menu">
				<ul>
				<li class="first "><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#">Day</a></li>
				<li class="sel"><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#">Week</a></li>
				<li class="last"><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#">Month</a></li>
				</ul>
				</div>
			<table border="0" cellspacing="0" cellpadding="2" width="100%" align="center" class="table_calendar">
<tbody><tr>
<td colspan="7" style="padding: 0 0 0 0;">
<table border="0" cellspacing="0" cellpadding="3" align="center">
		<tbody><tr>
		
		<td class="calendar_next" nowrap=""> <a href="http://compliance.dev.webstores.net/acc_bo/index.php?section=tracking&ac=default&month=03&year=2013" class="calendar_next"><img border="0" src="Images/arr_left2.gif" alt="Prev Year" align="absmiddle"></a> <a href="http://compliance.dev.webstores.net/acc_bo/index.php?section=tracking&ac=default&month=2&year=2014" class="calendar_next"><img border="0" src="Images/arr_left1.gif" alt="Prev Month" align="absmiddle"></a>	</td>
	<td align="center" width="100%">
		<strong style="font-size: 10px; color: #434343;">March 2014</strong>
	</td>
	<td align="right" class="calendar_next" nowrap=""><a href="http://compliance.dev.webstores.net/acc_bo/index.php?section=tracking&ac=default&month=4&year=2014" class="calendar_next"><img border="0" src="Images/arr_right1.gif" alt="Next Month" align="absmiddle"></a> <a href="http://compliance.dev.webstores.net/acc_bo/index.php?section=tracking&ac=default&month=03&year=2015" class="calendar_next"><img border="0" src="Images/arr_right2.gif" alt="Nex Year" align="absmiddle"></a> </td>
</tr>
		</tbody></table> 

</td>
</tr>

	<tr>
		<td width="14%" align="center" class="calendar_day_name">Su</td>
		<td width="14%" align="center" class="calendar_day_name">Mo</td>
		<td width="14%" align="center" class="calendar_day_name">Tu</td>
		<td width="14%" align="center" class="calendar_day_name">We</td>
		<td width="14%" align="center" class="calendar_day_name">Th</td>
		<td width="14%" align="center" class="calendar_day_name">Fr</td>
		<td width="14%" align="center" class="calendar_day_name">Sa</td>
	</tr>
		<!-------------------START SHOW DATA--------------------------->
		<tr align="left" valign="top">
<td class="calendar_wed" align="center"></td>

<td class="calendar_wed" align="center"></td>

<td class="calendar_wed" align="center></td>

<td class="calendar_wed" align="center"></td>

<td class="calendar_wed" align="center"></td>

<td class="calendar_wed" align="center"></td>

<td class="calendar_sat" align="center">1</td>
</tr>

<tr align="left" valign="top">
<td class="calendar_sun" align="center">2</td>

<td class="calendar_mon" align="center">3</td>

<td class="calendar_tue" align="center">4</td>

<td class="calendar_wed" align="center">5</td>

<td class="calendar_thu" align="center">6</td>

<td class="calendar_fri" align="center">7</td>

<td class="calendar_sat" align="center">8</td>
</tr>

<tr align="left" valign="top">
<td class="calendar_sun" align="center">9</td>

<td class="calendar_mon" align="center">10</td>

<td class="calendar_tue" align="center">11</td>

<td class="calendar_wed" align="center">12</td>

<td class="calendar_curr" align="center">13</td>

<td class="calendar_fri" align="center">14</td>

<td class="calendar_sat" align="center">15</td>
</tr>

<tr align="left" valign="top">
<td class="calendar_sun" align="center">16</td>

<td class="calendar_mon" align="center">17</td>

<td class="calendar_tue" align="center">18</td>

<td class="calendar_wed" align="center">19</td>

<td class="calendar_thu" align="center">20</td>

<td class="calendar_fri" align="center">21</td>

<td class="calendar_sat" align="center">22</td>
</tr>


<tr align="left" valign="top">
<td class="calendar_sun" align="center">23</td>

<td class="calendar_mon" align="center">24</td>

<td class="calendar_tue" align="center">25</td>

<td class="calendar_wed" align="center">26</td>

<td class="calendar_thu" align="center">27</td>

<td class="calendar_fri" align="center">28</td>

<td class="calendar_sat" align="center">29</td>
</tr>



		<!-------------------END SHOW DATA--------------------------->


</tbody></table>

<!-------------------END LIST--------------------------->


			<div class="spaser"></div>
			</div>
			<div class="spaser"></div>
		</div>
		
		<span id="week_calendar">
			<script>

			    function refresh_after_correction_action_added() {
			        $('#CORRECTION_ACTION_COMPLETION_FORM').adialog('close');

			        var params = unescape($('#LIST_correction_actions').text());
			        $.get('/acc_bo/?ac=list&name=correction_actions&' + params, function (data) {
			            $('#correction_actions_wrap').html(data)
			        })
			        var params = unescape($('#LIST_correction_actions_progress').text());
			        $.get('/acc_bo/?ac=list&name=correction_actions_progress&' + params, function (data) {
			            $('#correction_actions_progress_wrap').html(data)
			        })
			        var params = unescape($('#LIST_correction_actions_outstanding').text());
			        $.get('/acc_bo/?ac=list&name=correction_actions_outstanding&' + params, function (data) {
			            $('#correction_actions_outstanding_wrap').html(data)
			        })
			    }

			    function on_custom_jquery_init() {
			        $('.completion_form_opener').live('click', function () {
			            var tmp_id = $(this).attr('rel');
			            $('#CORRECTION_ACTION_ID').val(tmp_id);
			            //$('#CORRECTION_ACTION_ID').val(tmp_id);
			            // 
			            $('#CORRECTION_ACTION_COMPLETION_FORM_WAITING').hide();
			            $('#CORRECTION_ACTION_COMPLETION_FORM_CONTENT').show();
			            $('#CORRECTION_ACTION_COMPLETION_FORM').adialog('open');

			            return false;
			        });


			        var options = {
			            //target:        '#output2',   // target element(s) to be updated with server response 
			            //beforeSubmit:  showRequest,  // pre-submit callback 
			            success: refresh_after_correction_action_added  // post-submit callback 

			            // other available options: 
			            //url:       url         // override for form's 'action' attribute 
			            //type:      type        // 'get' or 'post', override for form's 'method' attribute 
			            //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
			            //clearForm: true        // clear all form fields after successful submit 
			            //resetForm: true        // reset the form after successful submit 

			            // $.ajax options can be used here too, for example: 
			            //timeout:   3000 
			        };

			        $('#CORRECTION_ACTION_COMPLETION_FORM_FORM').live('submit', function (e) {
			            e.preventDefault();
			            $('#correction_action' + $('#CORRECTION_ACTION_ID').val()).hide();
			            $('#CORRECTION_ACTION_COMPLETION_FORM_FORM').ajaxSubmit(options);
			            $('#CORRECTION_ACTION_COMPLETION_FORM_WAITING').show();
			            $('#CORRECTION_ACTION_COMPLETION_FORM_CONTENT').hide();
			            return false;
			        });




			    }
</script>

		<h5>March 16-22, 2014 (Week 11)</h5>
		<div class="print"><a href="" class="jsLink">Print</a></div>
		<div class="next-prev"><span class="prev"><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink" onclick="$(&#39;#week_calendar&#39;).load(&#39;?section=tracking&amp;ac=list&amp;name=calendar_week_report&amp;week=10&#39;)"></a></span><span class="next"><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink" onclick="$(&#39;#week_calendar&#39;).load(&#39;?section=tracking&amp;ac=list&amp;name=calendar_week_report&amp;week=12&#39;)"></a></span></div>
		<ul class="box_cont">
						<li class="box sun sun _line">
				<h3><strong>16 </strong>sun </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box mon mon _line">
				<h3><strong>17 </strong>mon </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box tue tue _line">
				<h3><strong>18 </strong>tue </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box wed wed _line">
				<h3><strong>19 </strong>wed </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box thu thu _line">
				<h3><strong>20 </strong>thu </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box fri fri _line">
				<h3><strong>21 </strong>fri </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>
			<li class="box sat sat _line">
				<h3><strong>22 </strong>sat </h3>
				
				<div class="box_in">
					
				</div>
				
				
			</li>

		</ul>
		
		
		<div id="CORRECTION_ACTION_COMPLETION_FORM" class="close_event_dd" style="display:none">
			<span id="CORRECTION_ACTION_COMPLETION_FORM_WAITING" style="display:none">
			Processing... Please wait...
			</span>
			<span id="CORRECTION_ACTION_COMPLETION_FORM_CONTENT" style="display:none">
			<form action="http://compliance.dev.webstores.net/acc_bo/index.php" method="POST" id="CORRECTION_ACTION_COMPLETION_FORM_FORM">
				<div>
				<ul>
					<li>This action was completed by:</li>
					<li><input type="text" name="DATA[COMPLETED_BY]" id="COMPLETED_BY" size="10" maxlength="255" value="" dir="ltr" class="mandatory"></li>
					<li>on</li>
					<li><select id="COMPLETEDDAYTE_MONTH" name="DATA[COMPLETEDDAYTE_MONTH]" size="1" align="absmiddle" placeholder="Month" class="_picker"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option></select></li>
					<li><select id="COMPLETEDDAYTE_DAY" name="DATA[COMPLETEDDAYTE_DAY]" size="1" align="absmiddle" placeholder="Day" class="_picker"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option></select></li>
					<li><select id="COMPLETEDDAYTE_YEAR" name="DATA[COMPLETEDDAYTE_YEAR]" size="1" align="absmiddle" placeholder="Year" class="_picker"><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option></select></li>
					<li>Further action required?</li>
					<li><input type="radio" id="MORE_ACTION_REQUIREDDATA[MORE_ACTION_REQUIRED]" name="DATA[MORE_ACTION_REQUIRED]" value="1" class="_picker"><label for="MORE_ACTION_REQUIREDDATA[MORE_ACTION_REQUIRED]">Yes</label> <input type="radio" id="MORE_ACTION_REQUIREDDATA[MORE_ACTION_REQUIRED]" name="DATA[MORE_ACTION_REQUIRED]" value="0" class="_picker"><label for="MORE_ACTION_REQUIREDDATA[MORE_ACTION_REQUIRED]">No</label></li>
					<li><input type="submit" value="Submit" name="submit"></li>
				</ul>
				</div>
				<input type="hidden" name="DATA[ID]" value="" id="CORRECTION_ACTION_ID">
				<input type="hidden" name="section" value="tracking">
                <input type="hidden" name="ac" value="update_correction_action">
                <input type="hidden" value="tracking" name="next_section">
                <input type="hidden" value="default" name="next_action">
                
                
			</form>
			</span>
		</div>
	  
		</span>
</div>

<!--10 pixels gap between middle and bottom-->
<div class="spaser" style="height: 5px;"></div>
	
	<div class="gray_box breakdown_gray_box">
		<div class="box_title">
			<h2>Past Due</h2>	
		</div>
	
		<div class="box_cont" id="box_cont_scroll">
		
			<ul>						
			<li class="box">
				<h3>Completed</h3>
					<div class="next-prev-vert">
					<span class="prev"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					<span class="next"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					</div>
				<span id="correction_actions_wrap">
				<!--Do not delete the SPAN below!!!!-->
<span id="LIST_correction_actions" style="display:none">%26LIST_NAME%3Dcorrection_actions%26QUERY%3DSELECT+%2A+FROM+%60tbl_corrections_action%60+WHERE+%60COMPLETED_BY%60+%21%3D+%27%27%26ENTIRE_LIST_TEMPLATE%3Dcorrection_actions_list.html%26ITEM_TEMPLATE%3Dcorrection_actions_completed_item.html%26PAGE_IDX%3D0%26NUMONPAGE%3D500</span>
<div class="jScrollPaneContainer" style="height: 205px; width: 275px;"><ul style="height: auto; overflow: visible; padding-bottom: 10px; width: 245px; padding-right: 0px; position: absolute; top: 0px;">
<li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="4">page completed action</a> Testing correction actions...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="7">uuuuuu</a> Something to do</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="9">Some more test!</a> Not important action... take your time</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="13">Ð²Ð°Ð¿Ð²Ð°Ð¿</a> Documents collection</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="15">lev</a> Repost previous</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="29">paige </a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="34">DON</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="35">Alex</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="36">DON</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="37">DON</a> RE: Compliance report...</li>
</ul><div class="jScrollPaneTrack" style="width: 0px; height: 181px; top: 12px; display: none;"><div class="jScrollPaneDrag" style="width: 0px; height: 1px; top: 0px;"><div class="jScrollPaneDragTop" style="width: 0px;"></div><div class="jScrollPaneDragBottom" style="width: 0px;"></div></div></div><a href="javascript:;" class="jScrollArrowUp disabled" style="width: 0px;">Scroll up</a><a href="javascript:;" class="jScrollArrowDown" style="width: 0px;">Scroll down</a></div>
				</span>
				
			<div class="last-st"></div></li>
			
			<li class="box">
				<h3>In Progress</h3>
					<div class="next-prev-vert">
					<span class="prev"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					<span class="next"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					</div>
				<span id="correction_actions_progress_wrap">
				<!--Do not delete the SPAN below!!!!-->
<span id="LIST_correction_actions_progress" style="display:none">%26LIST_NAME%3Dcorrection_actions_progress%26QUERY%3DSELECT+%2A+FROM+%60tbl_corrections_action%60+WHERE+%28DATEDIFF%28+%60DEADLINE%60%2C+NOW%28+%29%29+%3C%3D+7%29+AND+%60COMPLETED_BY%60+%3D+%27%27+ORDER+BY+ID+DESC%26ENTIRE_LIST_TEMPLATE%3Dcorrection_actions_list.html%26ITEM_TEMPLATE%3Dcorrection_actions_item.html%26PAGE_IDX%3D0%26NUMONPAGE%3D500</span>
<div class="jScrollPaneContainer" style="height: 205px; width: 275px;"><ul style="height: auto; overflow: visible; padding-bottom: 10px; width: 245px; padding-right: 0px; position: absolute; top: 0px;">
<li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="33">Compliance Officer 1</a> corection  for itesm for lev</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="32">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="31">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="30">Compliance Officer 1</a> New Alex test!</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="28">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="27">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="26">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="25">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="20">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="19">Compliance Officer 1</a> RE: Compliance report...</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="17">Compliance Officer 1</a> Equip and forth</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="16">Compliance Officer 1</a> request and go</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="14">Compliance Officer 1</a> Inventarisation of all gear required</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="12">Compliance Officer 1</a> Make sure all licenses are up to date</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="11">Compliance Officer 1</a> Fire 1/2 of the staff</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="10">Compliance Officer 1</a> Correct this at once!</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="8">Compliance Officer 1</a> Action is required ASAP! </li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="6">Compliance Officer 1</a> Take some action now!!!</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="5">Compliance Officer 1</a> Documents preparation</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="3">Compliance Officer 1</a> Some other correction action</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="2">Compliance Officer 1</a> Correction action title</li><li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#" class="jsLink open_compliance_dialog_correction_action" itemid="1">Compliance Officer 1</a> RE: Compliance report...</li>
</ul><div class="jScrollPaneTrack" style="width: 0px; height: 181px; top: 12px; display: none;"><div class="jScrollPaneDrag" style="width: 0px; height: 1px; top: 0px;"><div class="jScrollPaneDragTop" style="width: 0px;"></div><div class="jScrollPaneDragBottom" style="width: 0px;"></div></div></div><a href="javascript:;" class="jScrollArrowUp disabled" style="width: 0px;">Scroll up</a><a href="javascript:;" class="jScrollArrowDown" style="width: 0px;">Scroll down</a></div>
				</span>
			<div class="last-st"></div></li>		
			
			<li class="box">
				<h3>Outstanding</h3>
					<div class="next-prev-vert">
					<span class="prev"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					<span class="next"><a class="jsLink" href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#"></a></span>
					</div>
				<span id="correction_actions_outstanding_wrap">
				<!--Do not delete the SPAN below!!!!-->
<span id="LIST_correction_actions_outstanding" style="display:none">%26LIST_NAME%3Dcorrection_actions_outstanding%26QUERY%3DSELECT+%2A+FROM+%60tbl_corrections_action%60+WHERE+%28DATEDIFF%28+%60DEADLINE%60%2C+NOW%28+%29%29+%3E+7%29+AND+%60COMPLETED_BY%60+%3D+%27%27+ORDER+BY+ID+DESC%26ENTIRE_LIST_TEMPLATE%3Dcorrection_actions_list.html%26ITEM_TEMPLATE%3Dcorrection_actions_item.html%26PAGE_IDX%3D0%26NUMONPAGE%3D500</span>
<div class="jScrollPaneContainer" style="height: 205px; width: 275px;"><ul style="height: 205px; overflow: hidden; padding: 15px 15px 10px; width: 245px;">

</ul></div>
				</span>
			<div class="last-st"></div></li>		
			
		</ul>
		
		<div class="spaser"></div>
		</div>
	
	</div>
	
	
<div class="spaser" style="height: 5px;"></div>


	<div class="gray_box more_gray_box">
		<div class="box_title">
			<h2>More Actions</h2>			
		</div>
		
		<div class="box_cont">
			<ul class="sort_links">
			<!-- 	 -->
				
				<li><a href="AuditsandInvestigations.aspx">Audits and Investigations</a></li>
				<li><a href="http://compliance.dev.webstores.net/acc_bo/index.php?section=tracking&ac=action_log">Corrective Action Log</a></li>
				<li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#">Quality Measurement</a></li>
				<li><a href="http://compliance.dev.webstores.net/acc_bo/?section=tracking#">Financial Measurement</a></li>
				
				
			</ul>
		</div>
	</div>
	
	
	
<!--10 pixels gap between middle and bottom-->
<div class="spaser" style="height: 10px;"></div>


</asp:Content>

