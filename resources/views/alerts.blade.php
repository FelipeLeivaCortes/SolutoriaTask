<div>
    @if ( session('success') )
        <script>
            Swal.fire({
                icon:   'success',
                title:  'Operación Exitosa',
                text:   "<?=session('success')?>",
            })
        </script>
    @endif

    @if (session('warning'))
        <script>
            Swal.fire({
                icon:   'warning',
                title:  'Advertencia',
                text:   "<?=session('warning')?>",
            })
        </script>
    @endif

    @if (session('info'))
        <script>
            Swal.fire({
                icon:   'info',
                title:  'Notificación',
                text:   "<?=session('info')?>",
            })
        </script>
    @endif

    @if (session('error'))
        <script>
            Swal.fire({
                icon:   'error',
                title:  'Error',
                text:   "<?=session('error')?>",
            })
        </script>
    @endif

    @if ($errors->any())
        @php
            $error_list = "";

            foreach( $errors->all() as $error ){
                $error_list  = $error_list . $error .'<br>';
            }

        @endphp

        <script>
            Swal.fire({
                icon:   'error',
                title:  'Errores',
                html:   "<?=$error_list?>",
            })
        </script>
    @endif
</div>