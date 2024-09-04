// Generated by js_of_ocaml
//# buildInfo:effects=false, kind=cmo, use-js-string=true, version=5.8.2

//# unitInfo: Provides: Dune__exe__Model
//# unitInfo: Requires: Definicije__Avtomat, Definicije__Trak, Definicije__ZagnaniAvtomat, Dune__exe__Vektor, Stdlib__List
(function
  (globalThis){
   "use strict";
   var runtime = globalThis.jsoo_runtime;
   function caml_call1(f, a0){
    return (f.l >= 0 ? f.l : f.l = f.length) == 1
            ? f(a0)
            : runtime.caml_call_gen(f, [a0]);
   }
   function caml_call2(f, a0, a1){
    return (f.l >= 0 ? f.l : f.l = f.length) == 2
            ? f(a0, a1)
            : runtime.caml_call_gen(f, [a0, a1]);
   }
   function caml_call3(f, a0, a1, a2){
    return (f.l >= 0 ? f.l : f.l = f.length) == 3
            ? f(a0, a1, a2)
            : runtime.caml_call_gen(f, [a0, a1, a2]);
   }
   var
    global_data = runtime.caml_get_global_data(),
    Definicije_ZagnaniAvtomat = global_data.Definicije__ZagnaniAvtomat,
    Stdlib_List = global_data.Stdlib__List,
    Definicije_Trak = global_data.Definicije__Trak,
    Definicije_Avtomat = global_data.Definicije__Avtomat,
    Dune_exe_Vektor = global_data.Dune__exe__Vektor;
   function init(sirina, visina, avtomat){
    var
     _f_ = caml_call1(Definicije_Avtomat[7], avtomat),
     _g_ = caml_call1(Stdlib_List[1], _f_),
     _h_ = caml_call3(Dune_exe_Vektor[8], _g_, sirina, visina),
     _i_ = caml_call1(Definicije_Avtomat[7], avtomat),
     polozaji = caml_call1(caml_call1(Stdlib_List[55], _i_), _h_);
    return [0,
            caml_call2
             (Definicije_ZagnaniAvtomat[1], avtomat, Definicije_Trak[1]),
            polozaji,
            0,
            sirina,
            visina];
   }
   function polozaj_stanja(model, q){
    return caml_call2(Stdlib_List[46], q, model[2]);
   }
   function update(model, param){
    if(typeof param === "number")
     switch(param){
       case 0:
        var match = caml_call1(Definicije_ZagnaniAvtomat[5], model[1]);
        if(! match) return model;
        var avtomat = match[1];
        return [0, avtomat, model[2], model[3], model[4], model[5]];
       case 1:
        return [0, model[1], model[2], 0, model[4], model[5]];
       default: return [0, model[1], model[2], 1, model[4], model[5]];
     }
    switch(param[0]){
      case 0:
       var q = param[1];
       return [0, model[1], model[2], [0, q], model[4], model[5]];
      case 1:
       var position = param[1], match$0 = model[3];
       if(typeof match$0 === "number") return model;
       var
        q$0 = match$0[1],
        polozaji =
          caml_call2
           (Stdlib_List[19],
            function(param){
             var
              position$0 = param[2],
              q = param[1],
              position$1 = runtime.caml_equal(q$0, q) ? position : position$0;
             return [0, q, position$1];
            },
            model[2]);
       return [0, model[1], polozaji, model[3], model[4], model[5]];
      default:
       var
        vneseni_niz = param[1],
        _a_ = model[5],
        _b_ = model[4],
        _c_ = model[2],
        _d_ = caml_call1(Definicije_Trak[5], vneseni_niz),
        _e_ = caml_call1(Definicije_ZagnaniAvtomat[2], model[1]);
       return [0,
               caml_call2(Definicije_ZagnaniAvtomat[1], _e_, _d_),
               _c_,
               0,
               _b_,
               _a_];
    }
   }
   var Dune_exe_Model = [0, init, polozaj_stanja, update];
   runtime.caml_register_global(5, Dune_exe_Model, "Dune__exe__Model");
   return;
  }
  (globalThis));

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLjAsImZpbGUiOiIuc3BsZXRuaVZtZXNuaWsuZW9ianMvanNvby9kdW5lX19leGVfX01vZGVsLmNtby5qcyIsInNvdXJjZVJvb3QiOiIiLCJuYW1lcyI6WyJpbml0Iiwic2lyaW5hIiwidmlzaW5hIiwiYXZ0b21hdCIsInBvbG96YWppIiwicG9sb3phal9zdGFuamEiLCJtb2RlbCIsInEiLCJ1cGRhdGUiLCJwb3NpdGlvbiIsInEkMCIsInBvc2l0aW9uJDAiLCJwb3NpdGlvbiQxIiwidm5lc2VuaV9uaXoiXSwic291cmNlcyI6WyIvd29ya3NwYWNlX3Jvb3Qvc3JjL3NwbGV0bmlWbWVzbmlrL21vZGVsLm1sIl0sIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7Rzs7Ozs7Rzs7Ozs7Rzs7Ozs7Ozs7Ozs7O1lBWUlBLEtBQUtDLFFBQU9DLFFBQU9DO0lBQ3JCO0tBRWlCLE1BQUEsa0NBSElBO0tBR2pCLE1BQUE7S0FERixNQUFBLG9DQUZLRixRQUFPQztLQUtJLE1BQUEsa0NBTEdDO0tBQ2pCQyxXQUNGLFdBR0c7SUFFTDtZQUNZOzRDQVJTRDtZQUNqQkM7O1lBREdIO1lBQU9DO0dBYWI7WUFVQ0csZUFBZUMsT0FBTUM7SUFBSSxtQ0FBSkEsR0FBTkQ7R0FBcUM7WUFFcERFLE9BQU9GO0k7OztRQUVDLFlBQUEseUNBRkRBO29CQUdLLE9BSExBO1lBSUVIO1FBQVksV0FBWkEsU0FKRkcsVUFBQUEsVUFBQUEsVUFBQUE7O1FBaUJpQixXQWpCakJBLFVBQUFBLGFBQUFBLFVBQUFBO2dCQWtCVSxXQWxCVkEsVUFBQUEsYUFBQUEsVUFBQUE7Ozs7V0FLYUM7T0FBSyxXQUxsQkQsVUFBQUEsY0FLYUMsSUFMYkQsVUFBQUE7O09BTXNCLElBQVpHLHFCQUFZLFVBTnRCSDt1Q0FnQkUsT0FoQkZBO09BVUM7UUFGZUk7UUFDYk47VUFDRjs7O2FBQ0U7Y0FBVU87Y0FBSko7Y0FMQ0ssYUFNRyxtQkFKR0YsS0FHUEgsS0FMQ0UsV0FLR0U7YUFDUixXQURJSixHQUxDSztZQU13QztZQVpsRE47T0FlRCxXQWZDQSxVQVNHRixVQVRIRSxVQUFBQSxVQUFBQTs7T0F5QkM7UUFOQ087Y0FuQkZQO2NBQUFBO2NBQUFBO1FBeUJDLE1BQUEsK0JBTkNPO1FBS0QsTUFBQSx5Q0F4QkRQO09Bb0JMO2VBR0k7Ozs7Ozs7NEJBaEROTixNQXVCQUssZ0JBRUFHOzs7RSIsInNvdXJjZXNDb250ZW50IjpbIm9wZW4gRGVmaW5pY2lqZVxuXG50eXBlIG5hY2luID0gUHJpdnpldE5hY2luIHwgVm5hc2FuamVOaXphIHwgUHJlbWlrYW5qZVZvemxpc2NhIG9mIFN0YW5qZS50XG5cbnR5cGUgbW9kZWwgPSB7XG4gIGF2dG9tYXQgOiBaYWduYW5pQXZ0b21hdC50O1xuICBwb2xvemFqaSA6IChTdGFuamUudCAqIFZla3Rvci50KSBsaXN0O1xuICBuYWNpbiA6IG5hY2luO1xuICBzaXJpbmEgOiBmbG9hdDtcbiAgdmlzaW5hIDogZmxvYXQ7XG59XG5cbmxldCBpbml0IHNpcmluYSB2aXNpbmEgYXZ0b21hdCA9XG4gIGxldCBwb2xvemFqaSA9XG4gICAgVmVrdG9yLmtvcmVuaV9lbm90ZVxuICAgICAgKExpc3QubGVuZ3RoIChBdnRvbWF0LnNlem5hbV9zdGFuaiBhdnRvbWF0KSlcbiAgICAgIHNpcmluYSB2aXNpbmFcbiAgICB8PiBMaXN0LmNvbWJpbmUgKEF2dG9tYXQuc2V6bmFtX3N0YW5qIGF2dG9tYXQpXG4gIGluXG4gIHtcbiAgICBhdnRvbWF0ID0gWmFnbmFuaUF2dG9tYXQucG96ZW5pIGF2dG9tYXQgVHJhay5wcmF6ZW47XG4gICAgcG9sb3phamk7XG4gICAgbmFjaW4gPSBQcml2emV0TmFjaW47XG4gICAgc2lyaW5hO1xuICAgIHZpc2luYTtcbiAgfVxuXG50eXBlIG1zZyA9XG4gIHwgUHJlYmVyaU5hc2xlZG5qaVpuYWtcbiAgfCBaYWNuaVByZW1pa1Zvemxpc2NhIG9mIFN0YW5qZS50XG4gIHwgUHJlbWFrbmlWb3psaXNjZSBvZiBWZWt0b3IudFxuICB8IEtvbmNhalByZW1pa1Zvemxpc2NhXG4gIHwgWmFjbmlWbm9zTml6YVxuICB8IFZuZXNpTml6IG9mIHN0cmluZ1xuXG5sZXQgcG9sb3phal9zdGFuamEgbW9kZWwgcSA9IExpc3QuYXNzb2MgcSBtb2RlbC5wb2xvemFqaVxuXG5sZXQgdXBkYXRlIG1vZGVsID0gZnVuY3Rpb25cbiAgfCBQcmViZXJpTmFzbGVkbmppWm5hayAtPiAoXG4gICAgICBtYXRjaCBaYWduYW5pQXZ0b21hdC5rb3Jha19uYXByZWogbW9kZWwuYXZ0b21hdCB3aXRoXG4gICAgICB8IE5vbmUgLT4gbW9kZWxcbiAgICAgIHwgU29tZSBhdnRvbWF0JyAtPiB7IG1vZGVsIHdpdGggYXZ0b21hdCA9IGF2dG9tYXQnIH0pXG4gIHwgWmFjbmlQcmVtaWtWb3psaXNjYSBxIC0+IHsgbW9kZWwgd2l0aCBuYWNpbiA9IFByZW1pa2FuamVWb3psaXNjYSBxIH1cbiAgfCBQcmVtYWtuaVZvemxpc2NlIHBvc2l0aW9uIC0+IChcbiAgICAgIG1hdGNoIG1vZGVsLm5hY2luIHdpdGhcbiAgICAgIHwgUHJlbWlrYW5qZVZvemxpc2NhIHEgLT5cbiAgICAgICAgICBsZXQgcG9sb3phamkgPVxuICAgICAgICAgICAgTGlzdC5tYXBcbiAgICAgICAgICAgICAgKGZ1biAocScsIHBvc2l0aW9uJykgLT5cbiAgICAgICAgICAgICAgICAocScsIGlmIHEgPSBxJyB0aGVuIHBvc2l0aW9uIGVsc2UgcG9zaXRpb24nKSlcbiAgICAgICAgICAgICAgbW9kZWwucG9sb3phamlcbiAgICAgICAgICBpblxuICAgICAgICAgIHsgbW9kZWwgd2l0aCBwb2xvemFqaSB9XG4gICAgICB8IF8gLT4gbW9kZWwpXG4gIHwgS29uY2FqUHJlbWlrVm96bGlzY2EgLT4geyBtb2RlbCB3aXRoIG5hY2luID0gUHJpdnpldE5hY2luIH1cbiAgfCBaYWNuaVZub3NOaXphIC0+IHsgbW9kZWwgd2l0aCBuYWNpbiA9IFZuYXNhbmplTml6YSB9XG4gIHwgVm5lc2lOaXogdm5lc2VuaV9uaXogLT5cbiAgICAgIHtcbiAgICAgICAgbW9kZWwgd2l0aFxuICAgICAgICBhdnRvbWF0ID1cbiAgICAgICAgICBaYWduYW5pQXZ0b21hdC5wb3plbmlcbiAgICAgICAgICAgIChaYWduYW5pQXZ0b21hdC5hdnRvbWF0IG1vZGVsLmF2dG9tYXQpXG4gICAgICAgICAgICAoVHJhay5pel9uaXphIHZuZXNlbmlfbml6KTtcbiAgICAgICAgbmFjaW4gPSBQcml2emV0TmFjaW47XG4gICAgICB9XG4iXX0=
