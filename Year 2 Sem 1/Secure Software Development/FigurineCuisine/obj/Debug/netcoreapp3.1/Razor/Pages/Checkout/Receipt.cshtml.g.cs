#pragma checksum "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "c22ab2db3eb543d60c12e034ec3a2c9fd891e735"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(FigurineCuisine.Pages.Checkout.Pages_Checkout_Receipt), @"mvc.1.0.razor-page", @"/Pages/Checkout/Receipt.cshtml")]
namespace FigurineCuisine.Pages.Checkout
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\_ViewImports.cshtml"
using FigurineCuisine;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
using Microsoft.AspNetCore.Identity;

#line default
#line hidden
#nullable disable
#nullable restore
#line 3 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
using FigurineCuisine.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"c22ab2db3eb543d60c12e034ec3a2c9fd891e735", @"/Pages/Checkout/Receipt.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"fa5bc3c263fd03736345c391680e136330d66da2", @"/Pages/_ViewImports.cshtml")]
    public class Pages_Checkout_Receipt : global::Microsoft.AspNetCore.Mvc.RazorPages.Page
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("method", "post", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("\n");
#nullable restore
#line 7 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
  
    ViewData["Title"] = "Check Out";

#line default
#line hidden
#nullable disable
            WriteLiteral("\n<div class=\"container\">\n    <h1>Receipt</h1>\n    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "c22ab2db3eb543d60c12e034ec3a2c9fd891e7354132", async() => {
                WriteLiteral("\n        <div class=\"form-group row\">\n            <div class=\"container\">\n                <div class=\"card\">\n                    <div class=\"card-header\">\n                        Invoice\n                        <strong>");
#nullable restore
#line 19 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                           Write(DateTime.Now.ToString("MM/dd/yyyy hh:mm tt"));

#line default
#line hidden
#nullable disable
                WriteLiteral(@"</strong>
                    </div>
                    <div class=""card-body"">
                        <div class=""row mb-4"">
                            <div class=""col-sm-12"">
                                <h6 class=""mb-3"">Ship To:</h6>
                                <div>
                                    <strong>");
#nullable restore
#line 26 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                       Write(Model.user.FirstName);

#line default
#line hidden
#nullable disable
                WriteLiteral(" ");
#nullable restore
#line 26 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                             Write(Model.user.LastName);

#line default
#line hidden
#nullable disable
                WriteLiteral("</strong>\n                                </div>\n                                <div>");
#nullable restore
#line 28 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                Write(Model.user.Address);

#line default
#line hidden
#nullable disable
                WriteLiteral("</div>\n                                <div>");
#nullable restore
#line 29 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                Write(Model.user.Region);

#line default
#line hidden
#nullable disable
                WriteLiteral(", ");
#nullable restore
#line 29 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                    Write(Model.user.PostalCode);

#line default
#line hidden
#nullable disable
                WriteLiteral(@"</div>
                                <div></div>
                            </div>
                        </div>

                        <div class=""table-responsive-sm"">
                            <table class=""table table-striped"">
                                <thead>
                                    <tr>
                                        <th class=""center"">#</th>
                                        <th>Category</th>
                                        <th>Product Name</th>
                                        <th class=""right"">Unit Cost</th>
                                        <th class=""center"">Qty</th>
                                        <th class=""right"">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
");
#nullable restore
#line 47 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                      int i = 1;
                                        foreach (var item in Model.CartItem)
                                        {

#line default
#line hidden
#nullable disable
                WriteLiteral("                                            <tr>\n                                                <td class=\"center\">");
#nullable restore
#line 51 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                               Write(i);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n                                                <td class=\"left strong\">");
#nullable restore
#line 52 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                                   Write(item.Figurine.Category);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n                                                <td class=\"left\">");
#nullable restore
#line 53 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                            Write(item.Figurine.Name);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n                                                <td class=\"right\">");
#nullable restore
#line 54 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                             Write(item.Figurine.Price);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n                                                <td class=\"center\">");
#nullable restore
#line 55 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                              Write(item.Quantity);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n                                                <td class=\"right\">");
#nullable restore
#line 56 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                              Write(item.Quantity * item.Figurine.Price);

#line default
#line hidden
#nullable disable
                WriteLiteral("</td>\n");
#nullable restore
#line 57 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                  i++;

#line default
#line hidden
#nullable disable
                WriteLiteral("                                            </tr>\n");
#nullable restore
#line 59 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                        }
                                    

#line default
#line hidden
#nullable disable
                WriteLiteral(@"                                </tbody>
                            </table>
                        </div>
                        <div class=""row"">
                            <div class=""col-lg-4 col-sm-5"">
                            </div>
                            <div class=""col-lg-4 col-sm-5 ml-auto"">
                                <table class=""table table-clear"">
                                    <tbody>
                                        <tr>
                                            <td class=""left"">
                                                <strong>Total</strong>
                                            </td>
");
#nullable restore
#line 74 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                              decimal total = 0;
                                                foreach (var item in Model.CartItem)
                                                {
                                                    total += item.Quantity * item.Figurine.Price;
                                                }
                                            

#line default
#line hidden
#nullable disable
                WriteLiteral("                                            <td class=\"right\">$");
#nullable restore
#line 80 "D:\FigurineCuisine-master\FigurineCuisine-master\FigurineCuisine\Pages\Checkout\Receipt.cshtml"
                                                          Write(total);

#line default
#line hidden
#nullable disable
                WriteLiteral(@"</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <button type=""submit"" class=""btn btn-outline-success"">Go back Shopping</button>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    ");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Method = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\n    \n</div>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public UserManager<ApplicationUser> usermanager { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<FigurineCuisine.Pages.Checkout.ReceiptModel> Html { get; private set; }
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<FigurineCuisine.Pages.Checkout.ReceiptModel> ViewData => (global::Microsoft.AspNetCore.Mvc.ViewFeatures.ViewDataDictionary<FigurineCuisine.Pages.Checkout.ReceiptModel>)PageContext?.ViewData;
        public FigurineCuisine.Pages.Checkout.ReceiptModel Model => ViewData.Model;
    }
}
#pragma warning restore 1591
