window.exibirModal = (modal_title, modal_body, modal_footer) ->
  modal_footer = modal_footer || "<button type='button' class='btn btn-outline-info' data-dismiss='modal'>Fechar</button>"

  $("#modal_title").html(modal_title)
  $("#modal_body").html(modal_body)
  $("#modal_footer").html(modal_footer)
  $("#global_modal").modal("toggle")

window.showForm = () ->
  $('#available_product_id').val(0)
  $('.form-dv').removeClass('d-none')
  $('.btn-cadastrar').addClass('d-none')

window.hiddeForm = () ->
  $('#available_product_id').val(0)
  $('.form-dv').addClass('d-none')
  $('.btn-cadastrar').removeClass('d-none')

window.limparForm = () ->
  $('.form-title').html('Cadastrar Produto')
  $('#product_name_').val('')
  $('#product_description_').val('')
  $('#color_selected_id').val('0')
  $('#size').val('0')
  $('#qtd_').val('0')
  $('#available_product_id').val('0')
  $('.dv-color').removeClass('active')

window.editarForm = (id) ->
  limparForm()
  $('.form-title').html('Editar Produto')

  $.ajax '/available-products/show',
    type:     'GET'
    dataType: 'json'
    data:     { id:id }
    success: (data) ->
      showForm()

      $('#available_product_id').val(id)
      $('#product_name_').val(data.product.name)
      $('#product_description_').val(data.product.description)
      $('#size').val(data.size.id)
      $('#qtd_').val(data.qtd)
      $('#color_selected_id').val(data.color.id)
      $('#'+data.color.id).addClass('active')
    error: (jqXHR, data, errorThrown) ->
      exibirModal('BitEstoque',"<h6 class='text-center'>Erro ao buscar produto.</h6>")
  return false

window.listAvailableProducts = () ->
  $('.available-products-table tbody tr').remove()
  hiddeForm()

  $.ajax '/available-products/list',
    type:     'GET'
    dataType: 'json'
    data:     ''
    success: (data) ->
      if Object.keys(data).length == 0
        $('.available-products-table').addClass('d-none')
        $('.available-products-dv').prepend("<h6 class='mb-0 text-center available-products-msg'>Não há Produdos Disponíveis.</h6>")
      else
        $('.available-products-table').removeClass('d-none')
        $('.available-products-msg').remove()

        data.forEach (element) ->
          $('.available-products-table tbody').append(
            '<tr onclick="editarForm('+element.id+')">' +
              '<td title="'+element.product.description+'">'+element.product.name+'</td>' +
              '<td class="text-center" title="'+element.size.description+'">'+element.size.name+'</td>' +
              '<td class="text-center" title="Cor: '+element.color.name+'" style="background-color:'+element.color.code+'"></td>' +
              '<td class="text-center">'+element.qtd+'</td>' +
              '<td class="text-center btn-editar" title="Editar Produto"><i class="icon ion-ios-construct"></i></td>' +
            '</tr>'
          )
    error: (jqXHR, data, errorThrown) ->
      alert jqXHR.responseJSON.message
  return false

window.validateForm = () ->
  msg = ''

  if $('#product_name_').val() == ''
    msg = 'Preencha o nome do produto'
  else if $('#product_name_').val().length < 3 or $('#product_name_').val().length > 100
    msg = 'O nome do produto deve ter entre 3 e 100 caracteres.'
  else if $('#product_description_').val() == ''
    msg = 'Preencha a descrição do produto'
  else if $('#size').val() == '' or $('#size').val() == 0
    msg = 'Escolha o tamanho'
  else if $('#qtd_').val() == ''
    msg = 'Preencha a quantidade'
  else if $('#color_selected_id').val() == '0'
    msg = 'Escolha uma cor'

  if msg == ''
    return true
  else
    exibirModal('BitEstoque - Erro ao salvar',"<h6 class='text-center'>"+msg+"</h6>")
    return false

$(document).ready ->
  if parseInt($('.container-fluid').css('width')) < 769
    $('.dv-header').find('h4').replaceWith ->
      "<h5 class='"+this.className+"'>"+$(this).text()+'</h5>'

    $('.btn-cadastrar').parent('.col-11').addClass('text-center')
    $('.btn-salvar').parent('.col-12').addClass('text-center')

  listAvailableProducts()

  $('#qtd_').mask('99999999')

  $('.btn-cadastrar').click ->
    showForm()

  $('.btn-cancelar').click ->
    limparForm()
    hiddeForm()

  $('.dv-color').click ->
    $('#color_selected_id').val(this.id)
    $('.dv-color').removeClass('active')
    $(this).addClass('active')

  $('.btn-salvar').click ->
    if validateForm() == true
      action = if $('#available_product_id').val() == '0' then 'create' else 'update'
      type   = if action == 'create' then 'POST' else 'PUT'
      params = {
        product_name:         $('#product_name_').val(),
        product_descr:        $('#product_description_').val(),
        color_id:             $('#color_selected_id').val(),
        size_id:              $('#size').val(),
        qtd:                  $('#qtd_').val(),
        available_product_id: $('#available_product_id').val()
      }

      $.ajax 'available-products/'+action,
        type:     type
        dataType: 'json'
        data:     params
        success: (data) ->
          exibirModal('BitEstoque',"<h6 class='text-center'>"+data.message+"</h6>")
          limparForm()
          listAvailableProducts()
        error: (jqXHR, data, errorThrown) ->
          exibirModal('BitEstoque - Erro ao salvar',"<h6 class='text-center'>"+jqXHR.responseJSON.message+"</h6>")
      return false
