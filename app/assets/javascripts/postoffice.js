
$(document).ready(function() {

  function clear_form_cep() {
    $("#public_place").val("");
    $("#neighborhood").val("");
    $("#city").val("");
    $("#uf").val("");
    $("#ibge_code").val("");
  }
  
  $("#cep").blur(function() {
    var cep = $(this).val().replace(/\D/g, '');
    if (cep != "") {
      var validCep = /^[0-9]{8}$/;
      if(validCep.test(cep)) {
        $("#public_place").val("...");
        $("#neighborhood").val("...");
        $("#city").val("...");
        $("#uf").val("...");
        $("#ibge_code").val("...");
        $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(data) {
          if (!("erro" in data)) {
            $("#public_place").val(data.logradouro);
            $("#neighborhood").val(data.bairro);
            $("#city").val(data.localidade);
            $("#municipe_addresses_uf").val(data.uf);
            $("#ibge_code").val(data.ibge);
          }
          else {
            clear_form_cep();
            alert("CEP não encontrado.");
          }
        });
      }
      else {
        clear_form_cep();
        alert("Formato de CEP inválido.");
      }
    }
    else {
      clear_form_cep();
    }
  });
});
